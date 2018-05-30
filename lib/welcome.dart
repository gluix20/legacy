import 'package:flutter/material.dart';

import 'begin.dart';
import 'weed.dart';
import 'translations.dart';
import 'application.dart';

class WelcomePage extends StatefulWidget {
  String w = 'welcome';
  @override
  State<StatefulWidget> createState() => new WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    print('Hola ${user.lastName}');
    APPLIC.paragraph = '';

    APPLIC.appendP('Welcome, ');
    APPLIC.appendP(user.name);
    final String welcome_par = APPLIC.getP();

    return new Scaffold(

      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[
              new TextContainer(T(context, k: 'main_title1'),
                fontSize: 36.0, top: 40.0, bottom: 40.0, fontW: FontWeight.w700,),

              new Container(
                  child: new Image.asset(
                        'images/no-image.jpg', width: 600.0, height: 180.0, fit: BoxFit.cover,
                      ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 0.0),
              ),

              new TextContainer(T(context, t: welcome_par),
                fontSize: 36.0, top: 30.0, bottom: 30.0,),

              new TextContainer(T(context, k: 'story_lbl1'),
                fontSize: 20.0, top: 0.0, bottom: 30.0,),
              new TextContainer(T(context, k: 'protect_lbl1'),
                fontSize: 20.0, top: 0.0, bottom: 40.0,),

              new RaisedButton(
                child: new TextContainer(T(context, k: 'begin_bttn1'),),
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
