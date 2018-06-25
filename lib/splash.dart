import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'prefs.dart';

import 'weed.dart';
import 'tutorial.dart';
import 'application.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Size size;

  Future<int> _counter;
  int counter;

  Future<Null> _incrementCounter() {
    //final SharedPreferences prefs = await _prefs;
    final int counter = Prefs.getInt('counter') + 1;

    setState(() {
      _counter = Prefs.setInt('counter', counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = Prefs.getIntF('counter');
    counter = Prefs.getInt('counter');
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    Prefs.getString('fbToken') != '' ?
    print('Splash - Token: ${Prefs.getString('fbToken')}') :
    print('Splash - No Token yet.');

    Prefs.getString('fbExpires') != '' ?
    print('Splash - Expires: ${Prefs.getString('fbExpires')}') :
    print('Splash - No Expires yet.');


    //_incrementCounter();

    return new Scaffold(
      body: new Center( child:
        new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new FlutterLogo(
            colors: Colors.blue,
            size: 170.0,
          ),
          new Padding(padding: EdgeInsets.only(top: 25.0)),
          new Text('TREASURE',
            style: Theme.of(context).textTheme.display3
                .copyWith(fontWeight: FontWeight.w700),
          ),
      ],)
      ),
    );
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new TutorialPage()),
    );
  }
}