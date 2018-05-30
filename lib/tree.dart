import 'package:flutter/material.dart';
import 'topic.dart';
import 'weed.dart';
import 'translations.dart';

// This app is a stateful, it tracks the user's current choice.
class TreePage extends StatefulWidget {
  @override
  _TreePageState createState() => new _TreePageState();
}

class _TreePageState extends State<TreePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];
    List<Widget> row = [];
    int lastLevel = 1;

    for (var c in choices) {
      if (c.level > lastLevel) {
        tiles.add(new Container(
          child: new Row(
            children: row,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          height: 150.0,
        ));
        row = [];
        row.add(new CircleCard(choice: c));
      } else {
        row.add(new CircleCard(choice: c));
      }
      lastLevel = c.level;
    }

    if (row.isNotEmpty) {
      tiles.add(new Container(
        child: new Row(
          children: row,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        height: 150.0,
      ));
    }

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return new Scaffold(
      appBar: new MyAppBar(T(context, k: 'main_title1'), scaffoldKey: _scaffoldKey),
      body: new ListView(
        children: tiles,
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.level, this.hPosition});

  final String title;
  final IconData icon;
  final int level;
  final int hPosition;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Family', icon: Icons.directions_car, level: 1, hPosition: 1),
  const Choice(
      title: 'Pets', icon: Icons.directions_bike, level: 2, hPosition: 1),
  const Choice(
      title: 'Friends', icon: Icons.directions_boat, level: 2, hPosition: 2),
  const Choice(
      title: 'Education', icon: Icons.directions_bus, level: 2, hPosition: 3),
  const Choice(
      title: 'Family', icon: Icons.directions_railway, level: 3, hPosition: 1),
  const Choice(
      title: 'Pets', icon: Icons.directions_walk, level: 3, hPosition: 2),
  const Choice(
      title: 'Friends', icon: Icons.videogame_asset, level: 4, hPosition: 1),
  const Choice(title: 'Education', icon: Icons.video_call, level: 5, hPosition: 1),
  const Choice(title: 'Weather', icon: Icons.ac_unit, level: 5, hPosition: 2),
  const Choice(title: 'Desserts', icon: Icons.cake, level: 6, hPosition: 3),
  const Choice(
      title: 'Travel', icon: Icons.airplanemode_active, level: 6, hPosition: 1),
  const Choice(
      title: 'Languages', icon: Icons.translate, level: 6, hPosition: 2),
];


class CircleCard extends StatelessWidget {
  CircleCard({Key key, this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    //print(MediaQuery.of(context).size.width);

    return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new TopicPage(choice)),
              );
            },
            child: new Column(
              children: <Widget>[
            new Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                border: new Border.all(
                  width: 2.0,
                  color: Colors.blueGrey,
                ),
              ),
              child: new Center(
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.center,
                child: //ren: <Widget>[
                    new Icon(choice.icon, size: 60.0, color: textStyle.color),
                //new Text(choice.title, style: textStyle),
                // ],
              ),
            ),
                new Text(choice.title),
              ],
            )

    );
  }
}
