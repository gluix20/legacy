import 'package:flutter/material.dart';

import 'translations.dart';
import 'weed.dart';


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
    //print(context.widget);

    return new Scaffold(
        key: _scaffoldKey,
        drawer: new Drawer(),
        appBar: new MyAppBar(T(context, t: 'HOME'), scaffoldKey: _scaffoldKey,
        backgroundColor: Colors.white, textColor: Colors.blue,),
        body: new ListView(
          padding: new EdgeInsets.only(left: 30.0, right: 30.0),
          children: <Widget>[
          new MyTitle(title: T(context, t: 'Your Story'),
            subtitle: T(context, k: 'wisdom_lbl1'), appbar: true),

          new Container(

            child: new Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  onTap: () { null; },
                  child: new Row(
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
                  )
                )
                

                ],

            ),
          ),



        ],),

    );
    //Translations.of(context).locale.languageCode,
  }
}

class Circle extends StatelessWidget {
  final Icon icon;
  final Color color;
  Circle({this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(

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
    );
  }
}

