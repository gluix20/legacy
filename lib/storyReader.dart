import 'package:flutter/material.dart';

import 'weed.dart';
import 'dart:async';
import 'translations.dart';
import 'topics.dart';

class StoryReaderPage extends StatefulWidget {
  final String hint;
  StoryReaderPage({Key key, this.hint}) : super(key: key);

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
    return new Scaffold(
      key: scaffoldKey,
      appBar: new MyAppBar('POST', textColor: Colors.blue, fontSize: 18.0,
        backgroundColor: Colors.white30,
        actions: <Widget>[
          new GestureDetector(child: new TextContainer('Share', contAlign: Alignment.center,
            color: Colors.blue, fontW: FontWeight.w700,),
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
        padding: new EdgeInsets.symmetric(horizontal: 20.0),
        child: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new TextContainer(T(context, k: 'excepteur_lbl1'),
                fontSize: 44.0, top: 10.0, bottom: 40.0, contAlign: Alignment.centerLeft,
                align: TextAlign.left,
                fontW: FontWeight.w700, color: Colors.blue,),

              new Row(children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Icon(Icons.watch_later, color: Colors.blue, size: 20.0,),
                ),
                new Padding(padding: EdgeInsets.only(left: 10.0)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  new TextContainer(T(context, t: 'By Nate Geller'),
                    fontSize: 16.0, top: 0.0, bottom: 0.0, contAlign: Alignment.centerLeft,
                    align: TextAlign.left,
                    fontW: FontWeight.w700, color: Colors.blue,),
                  new TextContainer(T(context, t: 'June 2, 2017'),
                    fontSize: 15.0, top: 0.0, bottom: 0.0, contAlign: Alignment.centerLeft,
                    align: TextAlign.left,
                    fontW: FontWeight.normal, color: Colors.blue,),
                ],),

              ],),
              new Padding(padding: EdgeInsets.only(bottom: 40.0)),


              new Container(
                child: new TextContainer(widget.hint, color: Colors.blue,
                contAlign: Alignment.centerLeft, align: TextAlign.left,),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
