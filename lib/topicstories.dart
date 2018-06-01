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

    final double iconSize = screenSize.width * 0.045;
    final double fontSize = screenSize.width * 0.035;


    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new MyAppBar('Topic: ' + widget.topic.topic.toUpperCase(), fontSize: 18.0,
        backgroundColor: Colors.blue.shade200,
      ),
      bottomNavigationBar: new MyBottomNavBar(),
      body: new Stack(children: <Widget>[
        new Container(child: new Column(children: <Widget>[
          new Container(
            constraints: new BoxConstraints.expand(
              height: screenSize.height * 0.25,
              width: screenSize.width * 1.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.blue.shade200,
            ),
            child: new TextContainer(T(context, k: 'main_title1'),
                fontSize: 36.0, bottom: screenSize.height * 0.2 * 0.1, fontW: FontWeight.w700,
                color: Colors.white),
          ),
          //new Container()
        ],),),


      new ListView(
        padding: EdgeInsets.only(top: 130.0),
          children: <Widget>[
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),

              child: new FutureBuilder<List<Question>>(
                future: fetchQuestions(topic: widget.topic.topic.toLowerCase()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    final List<Widget> lt = new List<Widget>();
                    for(var q in snapshot.data) {
                      if(!q.isSkipped()) {
                        lt.add(
                          new Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: new BoxDecoration(
                              color: Colors.blue.shade50,
                            ),
                            child: new Column(children: <Widget>[
                              new TextContainer('Question:', color: Colors.blue,
                                fontSize: 16.0, contAlign: Alignment.centerLeft,
                              fontW: FontWeight.w700, top: 10.0,),

                              new TextContainer('${q.text}', color: Colors.blue,
                                fontSize: 24.0, contAlign: Alignment.centerLeft,
                                fontW: FontWeight.w700, top: 15.0, align: TextAlign.left,),

                              new TextContainer('${q.answer}', color: Colors.blue,
                                fontSize: 16.0, contAlign: Alignment.centerLeft, top: 10.0, bottom: 10.0,),

                              new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                new MyButton(text: 'MORE', type:'outline', width: 80.0, height: 40.0,
                                widget: new StoryReaderPage(hint: q.text),),

                                new MyCircleButton(circleSize: 50.0, borderColor: Colors.blue.shade100,
                                  icon: new Icon(Icons.edit, size: iconSize, color: Colors.blue),
                                  widgetNav: new StoryPage(hint: q.text),
                                ),
                                new MyCircleButton(circleSize: 50.0, borderColor: Colors.blue.shade100,
                                  icon: new Icon(Icons.input, size: iconSize, color: Colors.blue),),

                              ],),

                              new Padding(padding: EdgeInsets.only(top: 20.0))
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

class MyDialog extends Dialog {
  final Question question;

  MyDialog(this.question) : super();

  @override
  Widget build(BuildContext context) {
    return new AnimatedPadding(

      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,

      child: new MediaQuery.removeViewInsets(

        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: new Center(
          child: new ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 280.0, maxHeight: 570.0),
              /// This code is from Dialog Flutter Class, the Material Widget was substituted
              /// by the container in the method: getContainer.
              child: getContainer(context)
          ),
        ),
      ),
    );
  }


  Widget getContainer(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),

        //color: Colors.white30,
        decoration: new BoxDecoration(

          color: Colors.white,
          borderRadius: new BorderRadius.circular(20.0),
          border: new Border.all(
            width: 2.0,
            color: Colors.white,
          ),
        ),

        child: new Column(children: <Widget>[
          new TextContainer('${question.text}', color: Colors.blue,
              fontSize: 18.0, align: TextAlign.center, fontW: FontWeight.w700, bottom: 20.0, top: 30.0),
          new FlutterLogo(
            colors: Colors.blue,
            size: 200.0,
          ),

          new TextContainer(T(context, k: 'lorem_lbl1'),
            fontSize: 18.0, color: Colors.blue, top: 30.0, bottom: 30.0,),

          new Container(
            width: 250.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new MyButton(text: 'SKIP', type: 'outline', width: 80.0, height: 50.0,
                    widget: new StoryPage(hint: question.text)),
                new MyButton(text: 'WRITE', type: 'raised', width: 80.0, height: 50.0,
                    widget: new StoryPage(hint: question.text)),
              ],
            ),
            //padding: EdgeInsets.only(top: 70.0, bottom: 0.0),
          ),
        ],)
    );
  }
}
