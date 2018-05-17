import 'package:flutter/material.dart';

import 'registry.dart';

class StoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create Story", style: new TextStyle(
            fontSize: 20.0,
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
                  'Nate',
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontSize: 20.0,
                    //fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w700
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 0.0),
              ),

              new Container(
                child: new ListTile(
                  //leading: const Icon(Icons.person), //The icon prior the field.
                  title: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "What do you think of your city?", //It appears on textfield as help.
                    ),
                    style: new TextStyle(
                      fontSize: 20.0,
                      //fontFamily: 'Montserrat',
                      //fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),

              new RaisedButton(
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MyHomePage(title: 'New contact')),
                  );
                },
                child: new Text('Continue'),
              ),
            ]),

      ),
    );
  }
}


