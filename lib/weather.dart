import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'application.dart';



class Weather extends StatelessWidget {

  final Map<String, dynamic> data;
  Weather(this.data);
  Widget build(BuildContext context) {
    double temp = data['main']['temp'];
    return new Text(
      '${temp.toStringAsFixed(1)} °C',
      style: Theme.of(context).textTheme.display4,
    );
  }
}

class WeatherPage extends StatefulWidget {
  WeatherPageState createState() => new WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  Future<http.Response> _response;

  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
          'http://api.openweathermap.org/data/2.5/forecast'
              '?q=San+Francisco&units=metric&APPID=14cc828bff4e71286219858975c3e89a'
      );
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather Example"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: _refresh,
      ),
      body: new Center(
          child: new FutureBuilder(
              future: _response,
              builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
                if (!response.hasData)
                  return new Text('Loading...');
                else if (response.data.statusCode != 200) {
                  return new Text('Could not connect to weather service.');
                } else {
                  Map<String, dynamic> json = JSON.decode(response.data.body);
                  if (json['cod'] == 200)
                    return new Weather(json);
                  else
                    return new Text('Weather service error: $json.');
                }
              }
          )
      ),
    );
  }
}


/*
class User {
  final int id;
  final String name;
  final String lastName;
  final String email;

  User({this.id, this.name, this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['user'][0]['id'],
      name: json['user'][0]['name'],
      lastName: json['user'][0]['last name'],
    );
  }
}

*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fetch Data Example'),
        ),
        body: new Center(
          child: new FutureBuilder<User>(
            future: fetchUser(),
            builder: (context, snapshot) {
              //print(snapshot);
              if (snapshot.hasData) {
                return new Text(snapshot.data.name+' '+snapshot.data.lastName);
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}