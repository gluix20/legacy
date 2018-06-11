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

    final double hPadding = size.width * 0.1;


    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new MyAppBar(widget.topic.topic.toUpperCase(), context: context,
        leading: new IconButton(icon: new Icon(Icons.arrow_back,
          color: Theme.of(context).textTheme.title.color,),
            onPressed: () => Navigator.pop(context)
        ),
      ),
      body: new ListView(
        padding: EdgeInsets.symmetric(horizontal: hPadding),

        children: <Widget>[
          new Container(
            height: size.height * 0.2,
            alignment: Alignment.center,
            child: new Text(T(context, k: 'lorem_lbl1'),
              style: Theme.of(context).textTheme.body1, textAlign: TextAlign.center,),
          ),


          new Container(
            child: new FutureBuilder<List<Age>>(
              /// It calls the http GET method for AGES.
              future: fetchAges(),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  final List<Widget> lt = new List<Widget>();
                  for(var age in snapshot.data) {
                    if(!age.isSkipped()) {
                      lt.add(
                          new Container(
                            child: getBlock(size: size, age: age)
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

  Widget getBlock({Age age, Size size}) {
    final double iconSize = size.width * 0.1;

    return new Container(
      //width: topicWidth,
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: new Text(age.text.toUpperCase(), style: Theme.of(context).textTheme.title),
          ),

          new Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: new LinearProgressIndicator(value: 0.5, backgroundColor: Colors.blue.shade200,),
          ),

          new FutureBuilder<List<Question>>(
            future: fetchQuestions(age: age.text.toLowerCase(), topic: widget.topic.topic.toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Widget> lt = new List<Widget>();
                for(var q in snapshot.data) {
                  if(!q.isSkipped()) {
                    lt.add(
                      new Container(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                        child: new Row(
                          children: <Widget>[
                            new IconButton(icon: q.isAnswered()?
                              new Icon(Icons.favorite, color: Colors.blue,) :
                              new Icon(Icons.favorite_border, color: Colors.blue),
                              onPressed: () {
                                showDialog(context: context, builder: (BuildContext context){
                                  return new MyDialog(q);
                                },);
                            },
                            ),
                            new Expanded(

                              child: new Text('${q.text}',
                                  style: Theme.of(context).textTheme.body1, maxLines: 3),
                            ),

                            new IconButton(
                              icon: new Icon(Icons.keyboard_arrow_right, size: iconSize,
                                  color: Colors.blue),
                              onPressed: () {
                                showDialog(context: context, builder: (BuildContext context){
                                  return new MyDialog(q);
                                },);
                              },
                            ),

                          ],
                        )
                      ),
                    );
                  }
                }
                return new Column(
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
          new Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
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

class MyDialog extends Dialog {
  final Question question;
  Size size;

  MyDialog(this.question) : super();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final double hPadding = size.width * 0.05;

    return new AnimatedPadding(

      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.symmetric(horizontal: hPadding),
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
            constraints: BoxConstraints(minWidth: size.width, maxHeight: size.height * 0.75),
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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
        border: new Border.all(
          width: 2.0,
          color: Colors.white,
        ),
      ),

      child: new Column(children: <Widget>[

        new Text('${question.text}', style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,),
        new Padding(padding: EdgeInsets.only(top: size.height * 0.04)),

        new FlutterLogo(
          colors: Colors.blue,
          size: 150.0,
        ),
        new Padding(padding: EdgeInsets.only(top: size.height * 0.04)),

        new Text(T(context, k: 'lorem_lbl1'), style: Theme.of(context).textTheme.subhead,
          textAlign: TextAlign.center,),
        new Padding(padding: EdgeInsets.only(top: size.height * 0.04)),

        new Container(
          //width: 250.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new MyButton(text: 'SKIP', type: 'outline',
              width: size.width * 0.2,
                  widget: new StoryPage(question: question)),
              new MyButton(text: 'WRITE', type: 'raised',
                  width: size.width * 0.2,
                  widget: new StoryPage(question: question)),
            ],
          ),
        ),
      ],)
    );
  }
}
