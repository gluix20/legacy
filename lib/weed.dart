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
      child: new Text(getS(context),
      //child: new Text(getS(context),
        textAlign: align == null? TextAlign.center : align,
        style: new TextStyle(
            fontSize: fontSize,
            fontFamily: 'Montserrat',
            fontWeight: fontW == null? FontWeight.normal : fontW,
            color: color == null? Colors.black : color,
        ),

      ),
      margin: new EdgeInsets.only(top: top, bottom: bottom),
    );
  }

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
