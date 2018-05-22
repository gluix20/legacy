import 'package:flutter/material.dart';

import 'begin.dart';
import 'weed.dart';
import 'translations.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[
              new TextContainer('main_title1', 36.0, 40.0, 40.0, null,FontWeight.w700),

              new Container(
                  child: new Image.asset(
                        'images/no-image.jpg', width: 600.0, height: 180.0, fit: BoxFit.cover,
                      ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 0.0),
              ),

              new TextContainer('welcome_lbl1', 36.0, 30.0, 30.0),
              new TextContainer('story_lbl1', 20.0, 0.0, 30.0),
              new TextContainer('protect_lbl1', 20.0, 0.0, 40.0),

              new RaisedButton(
                child: new TextContainer('begin_bttn1',14.0,0.0,0.0),
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
