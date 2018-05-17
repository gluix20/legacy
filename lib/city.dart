import 'package:flutter/material.dart';

import 'registry.dart';
import 'story.dart';

class CityScreen extends StatelessWidget {

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
                child:
                new Image.asset(
                  'images/no-image.jpg',
                  width: 600.0,
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
                margin: new EdgeInsets.only(top: 30.0, bottom: 30.0),
              ),

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
                margin: new EdgeInsets.only(top: 0.0, bottom: 30.0),
              ),

              new Container(
                //width: screenSize.width,
                child: new Text(
                  'Legends were born in New York City, we bet it was a really interesting place to born.',
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
                      hintText: "What do you think of your city?", //It appears on textfield as help.
                    ),

                  ),
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new MyHomePage(title: 'New contact')),
                    );
                  },

                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),

              ),

              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new StoryScreen()),
                  );
                },
                child: new Text('Continue'),
              ),
            ]),

      ),
    );
  }
}


