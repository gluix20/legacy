import 'package:flutter/material.dart';

class TextCont extends Container {

  TextCont(String text, double fontSize, double top, double bottom,
      [TextAlign align, FontWeight fontW]) :

    super(
      //width: screenSize.width,
      child: new Text(text,
        textAlign: align == null? TextAlign.center : align,
        style: new TextStyle(
          fontSize: fontSize,
          fontFamily: 'Montserrat',
          fontWeight: fontW == null? FontWeight.normal : fontW,
        ),
      ),
      margin: new EdgeInsets.only(top: top, bottom: bottom),
    );

}

class AppBarX extends AppBar {

  AppBarX(GlobalKey<ScaffoldState> _scaffoldKey) :
        super(title: new Text("TREASURE",
          style: new TextStyle(
              fontSize: 24.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold
          )),
        leading: new IconButton(icon: new Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
      );

  AppBarX.withTitle(String title) :
        super(title: new Text(title,
          style: new TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold
          )),
      );
}