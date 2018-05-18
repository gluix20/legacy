import 'package:flutter/material.dart';

import 'begin.dart';
import 'weed.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[
              new TextCont('TREASURE', 36.0, 40.0, 40.0, null,FontWeight.w700),

              new Container(
                  child: new Image.asset(
                        'images/no-image.jpg', width: 600.0, height: 180.0, fit: BoxFit.cover,
                      ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 0.0),
              ),

              new TextCont('Welcome, Nate.', 36.0, 30.0, 30.0),
              new TextCont('Your story is our Treasure.', 20.0, 0.0, 30.0),
              new TextCont('We\'ll protect your data as our own and we\'ll never share with anybody unless you want to.',
                  20.0, 0.0, 40.0),

              new RaisedButton(
                child: new Text('Let\'s begin'),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new BeginScreen()),
                  );
                },
              ),
            ]
        ),



      ),
    );
  }
}
