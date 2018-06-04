import 'package:flutter/material.dart';

import 'weed.dart';
import 'dart:async';
import 'translations.dart';
import 'topics.dart';

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
    final size = MediaQuery.of(context).size;

    return new Scaffold(
      key: scaffoldKey,
      appBar: new MyAppBar('WRITING', context: context,
        actions: <Widget>[
          new GestureDetector(

            child: new Container(
              alignment: Alignment.center,
              child: new Text('Save', style: Theme.of(context).textTheme.caption,),
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
      body: new Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05) +
        EdgeInsets.only(top: size.height * 0.05),
        child: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(T(context, k: 'excepteur_lbl1'),
                style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.normal),),
              new Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
              new Text(T(context, t: 'By Nate Geller'),
                style: Theme.of(context).textTheme.caption,),
              new Padding(padding: EdgeInsets.only(top: size.height * 0.04)),


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
                  style: Theme.of(context).textTheme.body1,
                ),
                margin: EdgeInsets.only(bottom: size.height * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
