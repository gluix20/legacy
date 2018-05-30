import 'package:flutter/material.dart';

import 'translations.dart';
import 'weed.dart';
import 'application.dart';


class StoriesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StoriesPageState();
}

class StoriesPageState extends State<StoriesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(icon: new Icon(Icons.menu), title: new Text('')),
        new BottomNavigationBarItem(icon: new Icon(Icons.edit), title: new Text('')),
        new BottomNavigationBarItem(icon: new Icon(Icons.person), title: new Text(''))
      ],
    );

    return new Scaffold(
        key: _scaffoldKey,
        drawer: new Drawer(),
        appBar: new MyAppBar(T(context, t: 'HOME'), scaffoldKey: _scaffoldKey,
          backgroundColor: Colors.white30, textColor: Colors.blue,),
        bottomNavigationBar: botNavBar,
        body: new ListView(

          padding: new EdgeInsets.only(left: 30.0, right: 30.0),
          children: <Widget>[
          new MyTitle(title: T(context, t: 'Your Story'),
            subtitle: T(context, k: 'wisdom_lbl1'), appbar: true),

          new Container(
            padding: new EdgeInsets.only(top: screenSize.height * 0.04),
            decoration: new BoxDecoration(
              color: Colors.white30,

            ),
            child: new Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                    children: <Widget>[
                      new Circle(color: Colors.blue,
                        icon: new Icon(Icons.place, size: 30.0, color: Colors.white),),

                      new Padding(padding: EdgeInsets.only(right: 15.0)),

                      new TextContainer('TOPIC', fontSize: 20.0, fontW: FontWeight.w700,
                      color: Colors.blue),

                      new Padding(padding: EdgeInsets.only(right: 30.0)),

                      new Circle(color: Colors.white,
                        icon: new Icon(Icons.apps, size: 30.0, color: Colors.blue),),

                      new Padding(padding: EdgeInsets.only(right: 15.0)),

                      new Circle(color: Colors.white,
                        icon: new Icon(Icons.add, size: 30.0, color: Colors.blue),),
                    ],
                  ),
/*
                new Container(
                  child: new FutureBuilder<List<Question>>(
                    future: fetchQuestions(widget.choice.title.toLowerCase()),
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
                        return new ListView(
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
                */
                ],
            ),
          ),
        ],),
    );
  }
}

class Circle extends StatelessWidget {
  final Icon icon;
  final Color color;
  Circle({this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () { null; },
    child: new Container(

      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.circular(50.0),
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

class Choice {
  const Choice({this.title, this.icon, this.level, this.hPosition});

  final String title;
  final IconData icon;
  final int level;
  final int hPosition;
}

