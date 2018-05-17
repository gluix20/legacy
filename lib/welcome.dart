import 'package:flutter/material.dart';

import 'begin.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('First Screen'),
      ),*/
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[

              new Container(
                //width: screenSize.width,
                child: new Text(
                  'TREASURE',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 36.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                margin: new EdgeInsets.only(top: 40.0, bottom: 40.0),
              ),
              new Image.asset(
                'images/no-image.jpg',
                width: 600.0,
                height: 180.0,
                fit: BoxFit.cover,
              ),
              new Container(
                //width: screenSize.width,
                child: new Text(
                  'Welcome, Nate.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 36.0,
                      //fontFamily: 'Montserrat',
                      //fontWeight: FontWeight.w700
                  ),
                ),
                margin: new EdgeInsets.only(top: 30.0, bottom: 30.0),
              ),
              new Container(
                //width: screenSize.width,
                child: new Text(
                  'Your story is our Treasure.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 20.0,
                    //fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w700
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 30.0),
              ),

              new Container(
                //width: screenSize.width,
                child: new Text(
                  'We\'ll protect your data as our own and we\'ll never share with anybody unless you want to.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 20.0,
                    //fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w700
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),

              new RaisedButton(
                child: new Text('Let\'s begin'),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new SecondScreen()),
                  );
                },
              ),
            ]
        ),



      ),
    );
  }
}
