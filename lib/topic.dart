import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'registry.dart';
import 'story.dart';
import 'weed.dart';
import 'application.dart';
import 'translations.dart';
import 'topics.dart';

class TopicPage extends StatefulWidget {
  final Topic topic;
  TopicPage(this.topic, {Key key}) :  super(key: key);

  @override
  _TopicPageState createState() => new _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {

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


    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new MyAppBar('Topic: ' + widget.topic.topic.toUpperCase(),),
      body: new ListView(
        children: <Widget>[
          new TextContainer(T(context, k: 'wisdom_lbl1'),
          fontSize: 18.0, color: Colors.blue, top: 30.0, bottom: 30.0,),

    new Container(
        child: new FutureBuilder<List<Question>>(
          future: fetchQuestions(topic: widget.topic.topic.toLowerCase()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<ListTile> lt = new List<ListTile>();

              for(var q in snapshot.data) {
                if(!q.isSkipped()) { lt.add( new ListTile(
                  title: new Text('${q.id} ${q.text}'),
                  leading: q.isAnswered()? new Icon(Icons.check_box) : new Icon(Icons.check_box_outline_blank),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new StoryPage(hint: q.text)),
                    );
                  },
                  trailing: new IconButton(
                      icon: new Icon(Icons.thumb_down),
                    onPressed: () {
                        print('Question ${q.id} Skipped');
                    },
                  ),
                )
                );
                }
              }
              return new Column(
                /// Receives a list of tiles constructed above in the future builder.
                ///
                children: lt
              );
              //return new Text(snapshot.data.name+' '+snapshot.data.lastName);


            } else if (snapshot.hasError) {


              return new Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return new Center(child: new CircularProgressIndicator());
          },
        ),
      ),
]),

    );
  }

  Widget getBlock(Age age, Size size) {
    final double iconSize = size.width * 0.065;
    final double fontSize = size.width * 0.035;
    //print(fontSize);

    return new Container(
      //margin: new EdgeInsets.only(bottom: size.height * 0.05),
      child: new Column(
        children: <Widget>[
          new Container(
            width: topicWidth,
            child: new Row(
              children: <Widget>[
                new TextContainer(age.text.toUpperCase(), fontSize: 20.0, color: Colors.blue,
                fontW: FontWeight.w700, bottom: 20.0,),
                new LinearProgressIndicator(value: 50.0),



                new Circle(

                  color: Colors.blue,
                  icon: new Icon(Icons.place, size: iconSize, color: Colors.white),
                  circleSize: circleWidth,
                ),

                new Padding(padding: EdgeInsets.only(right: topicPadding)),

                new TextContainer(age.text.toUpperCase(), fontSize: fontSize, fontW: FontWeight.w700,
                    color: Colors.blue),

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
                  color: Colors.white,
                  icon: new Icon(Icons.apps, size: iconSize, color: Colors.blue),
                  circleSize: circleWidth,
                ),

                new Circle(
                  type: 'plus',
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

  @override
  initState()  {
    super.initState();
  }
}

class Age {
  int id;
  String text;
  int skipped;
  int enabled;
  Age({this.id, this.text, this.skipped, this.enabled});

  bool isSkipped() => this.skipped == 1;
  bool isEnabled() => this.enabled == 1;
}

List<Age> ages = new List<Age>();

Future<List<Age>> fetchAges() async {
  final response =
  //await http.get('http://10.0.2.2:3000/db');
  await http.get('https://my-json-server.typicode.com/gluix20/treasure/db');
  final responseJson = json.decode(response.body);
  /// This method it's called every time the AgePage it's build
  /// but with the line below, the list of questions are reinitiallized.
  ///
  ages = new List<Age>();
  for (var q in responseJson['ages']) {
    Age newT = new Age(
      id: q['id'],
      text: q['text'],
      skipped: q['skipped'],
      enabled: q['id'] == 1 ? 1 : 0,
    );
    ages.add(newT);
  }
  return ages;
}