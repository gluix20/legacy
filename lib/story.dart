import 'package:flutter/material.dart';

import 'weed.dart';
import 'dart:async';


class StoryScreen extends StatefulWidget {
  StoryScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StoryScreenState createState() => new _StoryScreenState();
}


class _StoryScreenState extends State<StoryScreen> {
  final FocusNode n = new FocusNode();//Le tuve que poner final porque es stateless.

  @override
  initState()  {
      super.initState();
      focusOnTextField();

  }

  focusOnTextField() async {
    await sleep();
    FocusScope.of(context).requestFocus(n);
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 300),
            () => "1");
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBarX.withTitle("Create Story"),

      body: new Container(

        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children: <Widget>[
              new TextCont('Nate', 20.0, 0.0, 0.0, TextAlign.left),

              new Container(
                child: new ListTile(
                  //leading: const Icon(Icons.person), //The icon prior the field.
                  title: new TextField(
                    focusNode: n,
                    //autofocus: true,

                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration(

                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: "What do you think of your city?", //It appears on textfield as help.
                    ),
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      //fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),
/*
              new RaisedButton(
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage(title: 'New contact')),
                  );
                },
                child: new Text('Continue'),
              ),
              */
            ]),

      ),
    );

  }
}


