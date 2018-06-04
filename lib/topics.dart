import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'translations.dart';
import 'weed.dart';
import 'topic.dart';
import 'topicAnswers.dart';


class TopicsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TopicsPageState();
}

class TopicsPageState extends State<TopicsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double sidesWidth;
  double topicWidth;
  double actionWidth;
  Size screenSize;
  double circleWidth;
  double topicPadding;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    /// These have to sum 1.0
    sidesWidth = screenSize.width * 0.04;
    topicWidth = screenSize.width * 0.48;
    actionWidth = screenSize.width * 0.34;
    ///
    circleWidth = screenSize.width * 0.15;
    topicPadding = screenSize.width * 0.02;
    /// Review the way to make the fontSize a function of the length.

    return new Scaffold(
        key: _scaffoldKey,
        drawer: new Drawer(),
        appBar: new MyAppBar(T(context, t: 'HOME'), context: context,
          scaffoldKey: _scaffoldKey,),
        bottomNavigationBar: new MyBottomNavBar(),
        body: new ListView(
          children: <Widget>[
            new MyTitle(
                title: T(context, t: 'Your Story'),
                subtitle: T(context, k: 'wisdom_lbl1'), appbar: true
            ),

          new Container(
            padding: new EdgeInsets.only(left: sidesWidth, right: sidesWidth),
            child: new FutureBuilder<List<Topic>>(
              future: fetchTopics(),
              builder: (context, snapshot) {
                //print(snapshot.data[0].category);
                if (snapshot.hasData) {
                  final List<ListTile> lt = new List<ListTile>();

                  for(var topic in snapshot.data) {
                    if(!topic.isSkipped()) {
                      lt.add(
                        new ListTile(
                          title: getRow(topic, screenSize),
                          onTap: () {
                            null;
                          },
                        )
                      );
                    }
                  }
                  return new Column(
                    /// Receives a list of tiles constructed above in the future builder.
                    ///
                      children: lt
                  );

                } else if (snapshot.hasError) {

                  return new Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return new Center(child: new CircularProgressIndicator());
              },
            ),
          ),
        ],),
    );
  }

  Widget getRow(Topic topic, Size size) {
    final double iconSize = size.width * 0.065;
    final double fontSize = size.width * 0.035;
    print(fontSize);

    return new Container(

      margin: new EdgeInsets.only(bottom: size.height * 0.05),
      child: new Row(
      children: <Widget>[
        new Container(
          width: topicWidth,
          child: new Row(
            children: <Widget>[
              new Circle(

                color: Colors.blue,
                icon: new Icon(Icons.place, size: iconSize, color: Colors.white),
                circleSize: circleWidth,
              ),

              new Padding(padding: EdgeInsets.only(right: topicPadding)),
              new Text(topic.topic.toUpperCase(), style: Theme.of(context).textTheme.caption),
              new Padding(padding: EdgeInsets.only(right: topicPadding)),
            ],
          ),
        ),

        new Container(
          width: actionWidth,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

            new Circle(
              type: 'more',
              topic: topic,
              color: Colors.white,
              icon: new Icon(Icons.apps, size: iconSize, color: Colors.blue),
              circleSize: circleWidth,
            ),

            new Circle(
              type: 'plus',
              topic: topic,
              color: Colors.white,
              icon: new Icon(Icons.add, size: iconSize, color: Colors.blue),
              circleSize: circleWidth,
            ),
          ],),
        ),
      ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final Icon icon;
  final Color color;
  final double circleSize;
  final Topic topic;
  final String type;
  Circle({this.color, this.icon, this.circleSize, this.topic, this.type});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (type == 'more') {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new TopicStoriesPage(topic)),
          );

        } else if (type == 'plus') {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new TopicPage(topic)),
          );
        }
      },
      child: new Container(
        width: circleSize,
        height: circleSize,
        decoration: new BoxDecoration(
          color: color,
          borderRadius: new BorderRadius.circular(circleSize),
          border: new Border.all(
            width: 2.0,
            color: Colors.blue,
          ),
        ),
        child: new Center( child: icon ),
      )
    );
  }
}

class Topic {
  int id;
  String topic;
  int skipped;
  int enabled;
  Topic({this.id, this.topic, this.skipped, this.enabled});

  bool isSkipped() => this.skipped == 1;
  bool isEnabled() => this.enabled == 1;
}

List<Topic> topics = new List<Topic>();

Future<List<Topic>> fetchTopics() async {
  final response =
  //await http.get('http://10.0.2.2:3000/db');
  await http.get('https://my-json-server.typicode.com/gluix20/treasure/db');
  final responseJson = json.decode(response.body);
  /// This method it's called every time the TopicPage it's build
  /// but with the line below, the list of questions are reinitiallized.
  ///
  topics = new List<Topic>();
  for (var q in responseJson['topics']) {
    Topic newT = new Topic(
      id: q['id'],
      topic: q['text'],
      skipped: q['skipped'],
      enabled: q['id'] == 1 ? 1 : 0,
    );
    topics.add(newT);
  }
  return topics;
}

