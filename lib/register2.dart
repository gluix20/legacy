import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

import 'welcome.dart';
import 'translations.dart';
import 'weed.dart';
import 'topics.dart';


class Register2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Register2PageState();
}

class Register2PageState extends State<Register2Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double topPadding = screenSize.height * 0.05;
    final double bottomPadding = screenSize.height * 0.05;
    final double leftPadding = screenSize.width * 0.05;
    final double rightPadding = screenSize.width * 0.05;

    return new Scaffold(
      key: _scaffoldKey,
      body: new Column(
        children: <Widget>[
          new MyTitle(
            title: T(context, t: 'Welcome John'),
            subtitle: T(context, k: 'wisdom_lbl1'),
          ),

          new Container(
            constraints: new BoxConstraints.expand(
              height: screenSize.height * 0.70,
              width: screenSize.width * 1.0,
            ),

          /// It lets the input fields not to be at the edge of the screen.
          padding: new EdgeInsets.only(bottom: bottomPadding, left: 40.0, right: 40.0),
          child: new Form(
            key: this._formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                new TextContainer(T(context, k: 'tellus_lbl1'),
                  fontSize: 18.0, fontW: FontWeight.w700, color: Colors.blue,),

                new MyInput(label: 'Date of Birth', hint: '07/06/1987', menu: true),

                new MyInput(label: 'Country/Region', hint: 'United States', menu: true),

                new MyInput(label: 'State', hint: 'California', menu: true),

                new MyInput(label: 'City', hint: 'Roseville', menu: true),

                new Padding(padding: EdgeInsets.only(top: screenSize.height * 0.01)),

                new Container(
                  width: screenSize.width, height: 50.0,
                  child: new RaisedButton(
                    child: new Text('CONTINUE',
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new TopicsPage()),
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    disabledElevation: 0.0,
                    color: Colors.blue,
                    disabledColor: Colors.white,

                  ),
                ),
            ],),
          )
        ),
      ],
      )
    );
    //Translations.of(context).locale.languageCode,
  }
}
