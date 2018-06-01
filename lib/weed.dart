import 'package:flutter/material.dart';

import 'translations.dart';
import 'topics.dart';
import 'topic.dart';
import 'topicstories.dart';



class TextContainer extends StatelessWidget {

  final String text;
  final double fontSize;
  final double top;
  final double bottom;
  final TextAlign align;
  final FontWeight fontW;
  final Color color;
  final Alignment contAlign;

  TextContainer(this.text, {this.fontSize, this.top, this.bottom,
      this.align, this.fontW, this.color, this.contAlign}) : super();

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: contAlign ?? Alignment.center,
      margin: new EdgeInsets.only(top: top ?? 0.0, bottom: bottom ?? 0.0),
      child: new Text(
        text,
        textAlign: align ?? TextAlign.center,
        style: new TextStyle(
            fontSize: fontSize ?? 14.0,
            fontFamily: 'Montserrat',
            fontWeight: fontW ?? FontWeight.normal,
            color: color ?? Colors.black,
            decoration: TextDecoration.none
        ),
      ),
    );
  }
}



class MyAppBar extends AppBar {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final List<Widget> actions;
  final Widget leading;


  MyAppBar(this.text, {Key key, this.textColor, this.backgroundColor,
    this.scaffoldKey, this.fontSize, this.actions, this.leading}) :

        super(key: key,
        elevation: 0.0,
        backgroundColor: backgroundColor ?? Colors.blue,
        title: new TextContainer(text,
        fontSize: fontSize ?? 24.0,
          fontW: FontWeight.w700,
        color: textColor ?? Colors.white,),

        centerTitle: true,

        actions: actions ?? <Widget>[
          new IconButton(
            icon: new Icon(Icons.more_vert, color: textColor ?? Colors.white,),
            onPressed: () => print('Hola'),
          ),
        ],

        leading: leading ?? new IconButton(icon: new Icon(Icons.subject, color: textColor ?? Colors.white,),
          onPressed: () => scaffoldKey.currentState.openDrawer()),
    );
}

class MyInput extends StatelessWidget {

  final String label;
  final String hint;
  final bool obscureText;
  final bool menu;
  final String keyText;
  final double fontSize;
  final TextAlign align;
  final FontWeight fontW;
  final Color color;

  MyInput({Key key, this.label, this.hint, this.obscureText, this.menu,
    this.keyText, this.fontSize,
      this.align, this.fontW, this.color}): super(key: key);

  String getS(BuildContext context){
    return keyText == null? label : Translations.of(context).text(keyText);
  }

  @override
  Widget build(BuildContext context) {
    /*
    new TextFormField(
      decoration: new InputDecoration(
        hintText: 'Luis G',
        labelText: 'Nombre',
        hintStyle: new TextStyle(decoration: TextDecoration.underline),
        border: new OutlineInputBorder(

          borderSide: new BorderSide(color: Colors.red, width: 5.0, style: BorderStyle.solid),
        ),

      ),
    ),
    new Theme(
    data: Theme.of(context).copyWith(primaryColor: Colors.red),
      child: new TextField(
        decoration: new InputDecoration(
          labelText: "Hello",
          labelStyle: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    ),

    */

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          child: new Text(label,
            style: new TextStyle(color: Colors.blue, ),
            textAlign: TextAlign.left,
          ),
          padding: EdgeInsets.only(bottom: 8.0),
        ),

        new Container(
          //padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          height: 50.0,
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Colors.blueAccent,
              width: 1.0
            ),
            borderRadius: new BorderRadius.circular(0.0),
          ),
          child: new TextField(
            obscureText: obscureText ?? false,
            decoration: new InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 25.0, right: 10.0),
              suffixIcon: menu == null ? null :
              new Icon(Icons.keyboard_arrow_down, size: 28.0, color: Colors.blue,),
            ),
          ),
        ),
      ],
    );
  }
}

class MyTitle extends StatelessWidget {

  final String title;
  final String subtitle;
  final bool appbar;
  final Color color;

  MyTitle({Key key, this.title, this.subtitle, this.appbar, this.color}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    /// If there is no appbar the top padding for the title will be 10% of the screen.
    /// If there is, 3%. The between title and subtitle padding will be a 3% of the screen.
    ///
    final Size screenSize = MediaQuery.of(context).size;
    final topPadding = (appbar == null || !appbar) ? screenSize.height * 0.10 : screenSize.height * 0.03;
    final bottomPadding = screenSize.height * 0.05;
    final betweenPadding = screenSize.height * 0.03;
    final sidesWidth = screenSize.width * 0.10;

    final boxHeight = screenSize.height * 0.20;
    final boxWidth = screenSize.width * 1.0;

    //print('boxHeght: ${boxHeight} -- boxWidth: ${boxWidth} -- sidesWidth: ${sidesWidth}');
    //print('topPaading: ${topPadding} -- betweenPadding: ${betweenPadding} -- screenHeight: ${screenSize.height}');

    return new Container(

      //constraints: new BoxConstraints.expand(height: boxHeight, width: boxWidth,),
      padding: new EdgeInsets.only(
          top: topPadding, bottom: bottomPadding,
          left: sidesWidth, right: sidesWidth),
      child: new Column(
      children: <Widget>[
          (title != null) ? new TextContainer(title, fontSize: 24.0,
            fontW: FontWeight.w700, color: Colors.blue): new Text(''),

          (title != null) ? new Padding(padding: EdgeInsets.only(top: betweenPadding)) : new Text(''),

        new TextContainer(subtitle, fontSize: 18.0,
            color: Colors.blue),
      ],
    ),
    );
  }
}

class MyButton extends StatelessWidget {

  final String text;
  final double fontSize;
  final double top;
  final double bottom;
  final TextAlign align;
  final FontWeight fontW;
  final Color color;
  final String type;
  final double width;
  final Widget widget;
  final double height;

  MyButton({@required this.text, this.fontSize, this.top, this.bottom,
    this.align, this.fontW, this.color,
    @required this.type, @required this.width, this.widget, @required this.height}) : super();

  void action(BuildContext context) {
    Navigator.push( context,
        new MaterialPageRoute(builder: (context) => widget));
  }

  @override
  Widget build(BuildContext context) {
    final borderShape = new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0));

    if(type == 'outline') {
      return new OutlineButton(
        child: new Container(width: width, height: height, alignment: Alignment.center,
            child: new TextContainer(text, fontW: FontWeight.w700, color: Colors.blue,)),
        onPressed: () => action(context),
        color: Colors.white,
        shape: borderShape,
        borderSide: new BorderSide(width: 4.0, color: Colors.blue.shade100),
      );

    } else if(type == 'raised') {
      return new RaisedButton(
        child: new Container(width: width, height: height, alignment: Alignment.center,
            child: new TextContainer(text, fontW: FontWeight.w700, color: Colors.white,)),
        onPressed: () => action(context),
        shape: borderShape,
        elevation: 0.0,
        color: Colors.blue,
        disabledColor: Colors.white,
      );
    }


  }
}

class MyCircleButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final double circleSize;
  final Topic topic;
  final Widget widgetNav;
  final Color borderColor;


  MyCircleButton({this.color, this.icon, this.circleSize, this.topic,
    this.borderColor, this.widgetNav});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => widgetNav),
          );
        },
        child: new Container(
          width: circleSize,
          height: circleSize,
          decoration: new BoxDecoration(
            color: color,
            borderRadius: new BorderRadius.circular(circleSize),
            border: new Border.all(
              width: 2.0,
              color: borderColor ?? Colors.blue,
            ),
          ),
          child: new Center( child: icon ),
        )
    );
  }
}

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => new _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(icon: new Icon(Icons.menu, ), title: new Text('')),
        new BottomNavigationBarItem(icon: new Icon(Icons.edit, ), title: new Text('')),
        new BottomNavigationBarItem(icon: new Icon(Icons.person, ), title: new Text(''))
      ],
      //fixedColor: Colors.blue,
      //type: BottomNavigationBarType.fixed,

    );
  }
}



