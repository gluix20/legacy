import 'package:flutter/material.dart';

import 'registry.dart';
import 'city.dart';

class BeginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TREASURE", style: new TextStyle(
        fontSize: 24.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold)
      ),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[
              new Container(
                //width: screenSize.width,
                child: new Text(
                  'The beginning',
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
                  'They say wisdom comes with the years.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 20.0,
                    //fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w700
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),

              new Container(
                //width: screenSize.width,
                child: new Text(
                  'Let\'s start by knowing when and where you were born?',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 20.0,
                    //fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w700
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),

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

              new Container(
                //width: screenSize.width,
                child: new Text(
                  'I was born in',
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,

                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 20.0),
              ),

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


