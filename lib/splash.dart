import 'dart:async';

import 'package:flutter/material.dart';
import 'login.dart';
import 'intro.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new IntroPage()),
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
        child: new FlutterLogo(
          colors: Colors.blue,
          size: 170.0,
        ),
      ),
    );
  }
}