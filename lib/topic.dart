import 'package:flutter/material.dart';

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
          future: fetchQuestions(widget.topic.topic.toLowerCase()),
          builder: (context, snapshot) {
            //print(snapshot.data[0].category);
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

  @override
  initState()  {
    super.initState();
  }
}



