import 'package:flutter/material.dart';

import 'weed.dart';
import 'dart:async';
import 'translations.dart';
import 'application.dart';
import 'topics.dart';

class StoryReaderPage extends StatefulWidget {
  final Question question;
  StoryReaderPage({Key key, this.question}) : super(key: key);

  @override
  _StoryReaderPageState createState() => new _StoryReaderPageState();
}

class _StoryReaderPageState extends State<StoryReaderPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode n = new FocusNode();

  @override
  initState() {
    super.initState();
    focusOnTextField();
  }

  focusOnTextField() async {
    await sleep3();
    FocusScope.of(context).requestFocus(n);
  }

  focusSomewhereElse() async {
    await sleep3();
    Navigator.pop(context);
  }

  focusSave() async {
    await sleep3();
    final snackbar = new SnackBar(content: new Text('Saved.'));
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future sleep3() {
    return new Future.delayed(const Duration(milliseconds: 300), () => "1");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return new Scaffold(
      key: scaffoldKey,
      appBar: new MyAppBar('POST', context: context,
        actions: <Widget>[
          new GestureDetector(
            child: new Container(
              alignment: Alignment.center,
              child: new Text('Share', style: Theme.of(context).textTheme.caption,),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              focusSave();
              Navigator.push( context,
                  new MaterialPageRoute(builder: (context) => new TopicsPage()));
            },
          ),
        ],
        leading: new IconButton(icon: new Icon(Icons.arrow_back), color: Colors.blue,
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              focusSomewhereElse();
            }
        ),
      ),
      bottomNavigationBar: new MyBottomNavBar(),
      body: new Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1) +
          EdgeInsets.only(top: size.width * 0.05),
        child: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(T(context, k: 'excepteur_lbl1'), style: Theme.of(context).textTheme.display3),
              new Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),

              new Row(children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Icon(Icons.watch_later, color: Colors.blue, size: 20.0,),
                ),
                new Padding(padding: EdgeInsets.only(left: size.width * 0.02)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(T(context, t: 'By Nate Geller'), style: Theme.of(context).textTheme.body2),
                    new Text(T(context, t: 'June 2, 2017'), style: Theme.of(context).textTheme.body1),
                ],),

              ],),

              new Container(
                padding: new EdgeInsets.symmetric(vertical: size.height * 0.05),
                child: new Text(widget.question.answer, style: Theme.of(context).textTheme.body1),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
