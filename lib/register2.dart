import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

import 'welcome.dart';
import 'translations.dart';
import 'weed.dart';
import 'stories.dart';


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
    //print(context.widget);

    return new Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: new Column(children: <Widget>[

          new Container(
            /// It lets the input fields not to be at the edge of the screen.
            padding: new EdgeInsets.only(left: 40.0, right: 40.0),
            child: new Form(
              key: this._formKey,
              child: new Column(children: <Widget>[
                new MyTitle(title: T(context, t: 'Welcome John'),
                  subtitle: T(context, k: 'wisdom_lbl1'),),

                new TextContainer(T(context, k: 'tellus_lbl1'),
                  fontSize: 18.0, fontW: FontWeight.w700, color: Colors.blue,),

                new Padding(padding: EdgeInsets.only(top: 25.0)),

                new MyInput(label: 'Date of Birth', hint: '07/06/1987', menu: true),

                new Padding(padding: EdgeInsets.only(top: 25.0)),

                new MyInput(label: 'Country/Region', hint: 'United States', menu: true),

                new Padding(padding: EdgeInsets.only(top: 25.0)),

                new MyInput(label: 'State', hint: 'California', menu: true),

                new Padding(padding: EdgeInsets.only(top: 25.0)),

                new MyInput(label: 'City', hint: 'Roseville', menu: true),

                new Padding(padding: EdgeInsets.only(top: 25.0)),

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
                            builder: (context) => new StoriesPage()),
                      );

                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    disabledElevation: 0.0,
                    color: Colors.blue,
                    disabledColor: Colors.white,

                  ),
                  //margin: new EdgeInsets.only(top: 20.0, bottom: 0.0),
                ),

              ],),
            )
          ),
        ],
        )
      )
    );
    //Translations.of(context).locale.languageCode,
  }
}
