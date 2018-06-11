import 'dart:async';
import 'package:flutter/material.dart';

import 'weed.dart';
import 'tutorial.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Size screenSize;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new TutorialPage()),
    );

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FlutterLogo(
            colors: Colors.blue,
            size: 170.0,
          ),
          new Padding(padding: EdgeInsets.only(top: 25.0)),
          new TextContainer('TREASURE', color: Colors.blue,
            fontSize: 44.0, fontW: FontWeight.w700,
          )
      ],)
    );
  }
}