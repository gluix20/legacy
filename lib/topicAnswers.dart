import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'story.dart';
import 'weed.dart';
import 'application.dart';
import 'translations.dart';
import 'topics.dart';
import 'storyReader.dart';

class TopicStoriesPage extends StatefulWidget {
  final Topic topic;
  TopicStoriesPage(this.topic, {Key key}) :  super(key: key);

  @override
  _TopicStoriesPageState createState() => new _TopicStoriesPageState();
}

class _TopicStoriesPageState extends State<TopicStoriesPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double sidesWidth;
  double topicWidth;
  double actionWidth;
  Size size;
  double circleWidth;
  double topicPadding;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    /// These have to sum 1.0
    sidesWidth = size.width * 0.04;
    topicWidth = size.width * 0.48;
    actionWidth = size.width * 0.34;
    ///
    circleWidth = size.width * 0.15;
    topicPadding = size.width * 0.02;

    final double iconSize = size.width * 0.045;


    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new MyAppBar(widget.topic.topic.toUpperCase(),
          context: context, color: Colors.blue.shade200,
        leading: new IconButton(icon: new Icon(Icons.arrow_back,
          color: Theme.of(context).textTheme.title.color,),
            onPressed: () => Navigator.pop(context)
        ),
      ),
      bottomNavigationBar: new MyBottomNavBar(),
      body: new Stack(children: <Widget>[
        new Container(child: new Column(children: <Widget>[
          new Container(
            alignment: Alignment.center,
            constraints: new BoxConstraints.expand(
              height: size.height * 0.25,
            ),
            decoration: new BoxDecoration(
              color: Colors.blue.shade200,
            ),
            child: new Text(T(context, k: 'main_title1'),
              style: Theme.of(context).textTheme.display2),
          ),
          //new Container()
        ],),),

        new Container(
          /// I chose margin because I want to see the stack background.
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05) +
              EdgeInsets.only(top: size.height * 0.2),
          child: new ListView(
            children: <Widget>[
              new Container(
                child: new FutureBuilder<List<Question>>(
                  future: fetchQuestions(topic: widget.topic.topic.toLowerCase()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Widget> lt = new List<Widget>();
                      for(var q in snapshot.data) {
                        if(!q.isSkipped()) {
                          lt.add(
                            new Container(
                              margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,
                                  vertical: size.height * 0.03),
                              decoration: new BoxDecoration(
                                color: Colors.blue.shade50,
                              ),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                new Text('QUESTION', style: Theme.of(context).textTheme.caption,),
                                new Padding(padding: EdgeInsets.only(top: size.height * 0.04)),
                                new Text('${q.text}', style: Theme.of(context).textTheme.headline,),
                                new Padding(padding: EdgeInsets.only(top: size.height * 0.03)),
                                new Text('${q.answer}'.length >= 200 ? ('${q.answer}'.substring(0,200)+' ...') :
                                ('${q.answer} ...'),
                                  style: Theme.of(context).textTheme.body1,),
                                new Padding(padding: EdgeInsets.only(top: size.height * 0.03)),

                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new MyButton(text: 'MORE', type:'outline',
                                      width: size.width * 0.2,
                                      widget: new StoryReaderPage(question: q),),
                                    new Container(
                                      width: size.width * 0.32,
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new MyCircleButton(circleSize: size.width * 0.14, borderColor: Colors.blue.shade100,
                                            icon: new Icon(Icons.edit, size: iconSize, color: Colors.blue),
                                            widgetNav: new StoryPage(hint: q.text),
                                          ),
                                          new MyCircleButton(circleSize: size.width * 0.14, borderColor: Colors.blue.shade100,
                                            icon: new Icon(Icons.input, size: iconSize, color: Colors.blue),),
                                        ],
                                      ),
                                    ),
                                  ],),
                              ],)
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
          ),

      ],)
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