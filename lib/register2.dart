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
    final Size size = MediaQuery.of(context).size;
    final double topPadding = size.height * 0.05;
    final double bottomPadding = size.height * 0.075;
    final double hPadding = size.width * 0.1;

    return new Scaffold(
      key: _scaffoldKey,
      body: new Column(
        children: <Widget>[
          new MyTitle(
            title: T(context, t: 'Welcome John'),
            subtitle: T(context, k: 'wisdom_lbl1'),
          ),

          new Container(
            /// It lets the input fields not to be at the edge of the screen.
              padding: new EdgeInsets.only(bottom: bottomPadding)
                  + EdgeInsets.symmetric(horizontal: hPadding),
            constraints: new BoxConstraints.expand(
              height: size.height * 0.75,
            ),

            child: new Form(
              key: this._formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  new TextContainer(T(context, k: 'tellus_lbl1'),
                    fontSize: 16.0, fontW: FontWeight.w700, color: Colors.blue,),

                  new Column(
                    children: <Widget>[
                      new MyInput(label: 'Date of Birth', hint: '07/06/1987', menu: true, height: size.height * 0.075),
                      new MyInput(label: 'Country/Region', hint: 'United States', menu: true, height: size.height * 0.075),
                      new MyInput(label: 'State', hint: 'California', menu: true, height: size.height * 0.075),
                      new MyInput(label: 'City', hint: 'Roseville', menu: true, height: size.height * 0.075),
                    ],
                  ),

                  new MyButton(text: 'CONTINUE', type: 'raised',
                    width: size.width, height: size.height * 0.075,
                    widget: new TopicsPage(),),

              ],),
            )
          ),
        ],
      )
    );
    //Translations.of(context).locale.languageCode,
  }
}
