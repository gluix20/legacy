import 'package:flutter/material.dart';

import 'translations.dart';


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

class TextContainer extends StatelessWidget {

  final String text;
  final String keyText;
  final double fontSize;
  final double top;
  final double bottom;
  final TextAlign align;
  final FontWeight fontW;
  final Color color;

  TextContainer(this.keyText, this.fontSize, this.top, this.bottom,
      [this.align, this.fontW, this.color]):
        super();

  TextContainer.c(this.text, this.fontSize, this.top, this.bottom,
      [this.align, this.fontW, this.color]):
        super();

  TextContainer.t(this.keyText):
        super();

  String getS(BuildContext context){
    return keyText == null? text : Translations.of(context).text(keyText);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: top, bottom: bottom),
      child: new Text(getS(context),
        textAlign: align == null? TextAlign.center : align,
        style: new TextStyle(
            fontSize: fontSize == null? 14.0 : fontSize,
            fontFamily: 'Montserrat',
            fontWeight: fontW == null? FontWeight.normal : fontW,
            color: color == null? Colors.black : color,
        ),
      ),
    );
  }
}

class TranslatedText extends StatelessWidget {

  final String text;
  final String keyText;
  final double fontSize;
  final TextAlign align;
  final FontWeight fontW;
  final Color color;

  TranslatedText(this.keyText, this.fontSize,
      [this.align, this.fontW, this.color]):
        super();

  TranslatedText.c(this.text, this.fontSize,
      [this.align, this.fontW, this.color]):
        super();

  TranslatedText.t(this.keyText):
        super();

  String getS(BuildContext context){
    return keyText == null? text : Translations.of(context).text(keyText);
  }

  @override
  Widget build(BuildContext context) {
    return new Text(getS(context),
        //textAlign: align == null? TextAlign.center : align,
        style: new TextStyle(
          fontSize: fontSize == null? 14.0 : fontSize,
          fontFamily: 'Montserrat',
          fontWeight: fontW == null? FontWeight.normal : fontW,
          color: color == null? Colors.black : color,
        ),
    );
  }
}

class MyAppBar extends AppBar {
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyAppBar({Key key, this.scaffoldKey}) : super(
    key: key,
    title: new TranslatedText('main_title1',
        24.0, null, FontWeight.w700, Colors.white),
    centerTitle: true,
    actions: <Widget>[
      new IconButton(
        icon: new Icon(Icons.ac_unit),
        onPressed: () => print('Hola'),
      ),
    ],
    leading: new IconButton(icon: new Icon(Icons.menu),
        onPressed: () => scaffoldKey.currentState.openDrawer()),
  );
}

class AppBarX extends AppBar {
  final GlobalKey<ScaffoldState> scaffoldKey;
  AppBarX(this.scaffoldKey) :
        super(
        centerTitle: true,
        title: new TranslatedText('main_title1',
            24.0, null, FontWeight.w700, Colors.white),
        leading: new IconButton(icon: new Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState.openDrawer()),
      );

  AppBarX.withTitle(String title) :
        super(
        centerTitle: true,
        title: new TranslatedText.c(title,
            24.0, null, FontWeight.w700, Colors.white),
      );
}

class Translated extends Text {

  final String text;
  final String keyText;
  final double fontSize;
  final TextAlign align;
  final FontWeight fontW;
  final Color color;

  Translated({this.keyText, this.text, this.fontSize,
    this.align, this.fontW, this.color}):
        super('',
        //keyText == null? text : Translations.of(context).text(keyText),
        //textAlign: align == null? TextAlign.center : align,
        style: new TextStyle(
          fontSize: fontSize == null? 14.0 : fontSize,
          fontFamily: 'Montserrat',
          fontWeight: fontW == null? FontWeight.normal : fontW,
          color: color == null? Colors.black : color,
        ),
      );
}