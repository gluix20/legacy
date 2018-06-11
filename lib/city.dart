import 'package:flutter/material.dart';
import 'story.dart';
import 'weed.dart';
import 'application.dart';
import 'translations.dart';

class CityPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
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
    final String cityEx = APPLIC.getP();
    APPLIC.paragraph = '';
    APPLIC.appendP('Legends were born in ');
    APPLIC.appendP(city);
    APPLIC.appendP(', we bet it was a really interesting place to be born.');
    final String cityPar = APPLIC.getP();
    APPLIC.paragraph = '';

    return new Scaffold(
      appBar: new MyAppBar(T(context, k: 'main_title1'), scaffoldKey: widget.scaffoldKey, context: context,),
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

              new TextContainer(T(context, t: cityEx),
                fontSize: 36.0, top: 0.0, bottom: 30.0,),
              new TextContainer(T(context, t: cityPar),
                fontSize: 20.0, top: 0.0, bottom: 40.0,),

              new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new StoryPage(question: new Question(text: 'What do you thin of your city'))),
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



