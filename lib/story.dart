import 'package:flutter/material.dart';

import 'weed.dart';
import 'dart:async';

class StoryPage extends StatefulWidget {
  final String hint;
  StoryPage({Key key, this.hint}) : super(key: key);

  @override
  _StoryPageState createState() => new _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

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
      appBar: //new AppBarX.withTitle('Create Story'),
      new AppBar(title: new Text('Create story'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.save),
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                focusSave();
              }),
        ],
        leading: new IconButton(icon: new Icon(Icons.arrow_back),
          onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          focusSomewhereElse();
          }
        ),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new TextContainer.c('Nate', 18.0, 0.0, 10.0, TextAlign.left, FontWeight.w700),
              new Container(
                child: new TextField(
                  focusNode: n,
                  //autofocus: true,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: widget.hint,
                  ),
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                ),
                margin: new EdgeInsets.only(top: 0.0, bottom: 40.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
