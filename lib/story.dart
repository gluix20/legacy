import 'package:flutter/material.dart';

import 'weed.dart';
import 'dart:async';
import 'translations.dart';
import 'topics.dart';
import 'application.dart';

class StoryPage extends StatefulWidget {
  final Question question;

  StoryPage({Key key, this.question}) : super(key: key);

  @override
  _StoryPageState createState() => new _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode n = new FocusNode();
  TextEditingController controller = new TextEditingController();
  String currentText;
  String lastText;
  var lastPos;

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

  Future<String> sleep3() {
    return new Future.delayed(const Duration(milliseconds: 300), () => "1");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //if (MediaQueryData.of(context). == TargetPlatform.iOS) {

    //}
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
                child: getTextField(),
                margin: EdgeInsets.only(bottom: size.height * 0.05),

              ),
            ],
          ),
        ),
      ),
    );
  }


  TextField getTextField() {

    controller.addListener(listening);

    return new TextField(
      style: Theme.of(context).textTheme.body1,
      focusNode: n,
      //autofocus: true,
      controller: controller,
      /// maxLines has to be null if applies the 15572 issue solution.
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: new UnderlineInputBorder(), //InputBorder.none,
        hintText: widget.question.text,
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    controller.removeListener(listening);
    controller.dispose();
    super.dispose();
  }

  listening() {
  }
}
