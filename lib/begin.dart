import 'package:flutter/material.dart';

import 'registry.dart';
import 'city.dart';
import 'weed.dart';

class BeginScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new AppBarX(_scaffoldKey),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[

              new TextCont('The beginning', 36.0, 30.0, 30.0),
              new TextCont('They say wisdom comes with the years.', 20.0, 0.0, 40.0),
              new TextCont('Let\'s start by knowing when and where you were born?',
                  20.0, 0.0, 40.0),

              new Container(
                child: new ListTile(
                  //leading: const Icon(Icons.person), //The icon prior the field.
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Date of birth", //It appears on textfield as help.
                      suffixIcon: new Icon(Icons.arrow_drop_down,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
                      ),
                    ),
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),

              new TextCont('I was born in', 20.0, 0.0, 20.0, TextAlign.left, FontWeight.w700),


              new Container(
                child: new ListTile(
                  //leading: const Icon(Icons.person), //The icon prior the field.
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Select Country", //It appears on textfield as help.
                      suffixIcon: new Icon(Icons.arrow_drop_down,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
                      ),
                    ),
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 20.0),
              ),

              new Container(
                child: new ListTile(
                  //leading: const Icon(Icons.person), //The icon prior the field.
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Select City", //It appears on textfield as help.
                      suffixIcon: new Icon(Icons.arrow_drop_down,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
                      ),
                    ),
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 30.0),
              ),

              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new CityScreen()),
                  );
                },
                child: new Text('Continue'),
              ),
              ]),

      ),
    );
  }
}


