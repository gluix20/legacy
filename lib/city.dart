import 'package:flutter/material.dart';

import 'registry.dart';
import 'story.dart';
import 'weed.dart';
import 'application.dart';

class CityPage extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  CityPage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _CityPageState createState() => new _CityPageState();
}

class _CityPageState extends State<CityPage> {

  @override
  initState()  {
    super.initState();

  }
  final String city = 'New York City';

  @override
  Widget build(BuildContext context) {
    APPLIC.paragraph = '';
    APPLIC.appendP(city);
    APPLIC.appendP('!');
    final String city_ex = APPLIC.getP();
    APPLIC.paragraph = '';
    APPLIC.appendP('Legends were born in ');
    APPLIC.appendP(city);
    APPLIC.appendP(', we bet it was a really interesting place to be born.');
    final String city_par = APPLIC.getP();
    APPLIC.paragraph = '';

    return new Scaffold(
      appBar: new AppBarX(widget.scaffoldKey),
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

              new TextContainer.c(city_ex, 36.0, 0.0, 30.0),
              new TextContainer.c(city_par, 20.0, 0.0, 40.0),

              new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new StoryPage(hint: 'What do you think of your city?')),
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



