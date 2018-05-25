import 'dart:async';

import 'package:flutter/material.dart';
import 'login.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Icon(Icons.directions_car, size: 600.0),
        //new Image.asset('images/flutterwithlogo.png'),
      ),
    );
  }
}