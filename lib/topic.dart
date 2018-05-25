import 'package:flutter/material.dart';

import 'registry.dart';
import 'story.dart';
import 'weed.dart';
import 'application.dart';
import 'tree.dart';

class TopicPage extends StatefulWidget {
  final Choice choice;

  TopicPage(this.choice, {Key key}) :  super(key: key);

  @override
  _TopicPageState createState() => new _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState()  {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(),
      appBar: new AppBarX.withTitle('Topic: ' + widget.choice.title),
      body: new Container(
        child: new FutureBuilder<List<Question>>(
          future: fetchQuestions(widget.choice.title.toLowerCase()),
          builder: (context, snapshot) {
            //print(snapshot.data[0].category);
            if (snapshot.hasData) {
              final List<ListTile> lt = new List<ListTile>();
              for(var q in snapshot.data) {
                lt.add(new ListTile(
                  title: new Text('${q.id} ${q.text}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new StoryPage(hint: q.text)),
                    );
                  },
                )
                );
              }
              return new ListView(
                children: lt /*<Widget>[
                  //tiles,
                  new ListTile(
                    title: new Text('Pregunta1: ${widget.choice.title}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new StoryPage()),
                      );
                    },
                  ),

                  new ListTile(title: new Text('Pregunta2: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta3: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta4: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta5: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta1: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta2: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta3: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta4: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta5: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta1: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta2: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta3: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta4: ${widget.choice.title}'),),
                  new ListTile(title: new Text('Pregunta5: ${widget.choice.title}'),),

                ],*/
              );
              //return new Text(snapshot.data.name+' '+snapshot.data.lastName);


            } else if (snapshot.hasError) {


              return new Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return new CircularProgressIndicator();
          },
        ),
      ),


    );
  }
}



