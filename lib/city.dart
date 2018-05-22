import 'package:flutter/material.dart';

import 'registry.dart';
import 'story.dart';
import 'weed.dart';

class CityScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String city = 'New York City';

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
              new Container(
                child: new Image.asset('images/no-image.jpg', width: 600.0,
                  height: 180.0, fit: BoxFit.cover,
                ),
                margin: new EdgeInsets.only(top: 30.0, bottom: 30.0),
              ),

              new TextContainer.c(city+'!', 36.0, 0.0, 30.0),
              new TextContainer.c('Legends were born in '+city+
                  ', we bet it was a really interesting place to be born.', 20.0, 0.0, 40.0),

              new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new StoryScreen()),
                  );
                },
                child: new Container(
                  child: new ListTile(
                  //leading: const Icon(Icons.person), //The icon prior the field.

                    title: new TextField(
                      decoration: new InputDecoration(
                        hintText: 'What do you think of your city?', //It appears on textfield as help.
                      ),
                      enabled: false,
                    ),

                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),

              ),
              ),

            ]
        ),

      ),
    );
  }
}


