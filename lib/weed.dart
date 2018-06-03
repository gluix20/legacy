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
  final List<Widget> actions;
  final Widget leading;
  final BuildContext context;

  MyAppBar(this.text, {Key key, @required this.context,
    this.scaffoldKey, this.actions, this.leading}) :

        super(key: key,
        elevation: 0.0,
        backgroundColor: Colors.white30,
        title: new Text(text, style: Theme.of(context).textTheme.title,),
        centerTitle: true,

        actions: actions ?? <Widget>[
          new IconButton(
            icon: new Icon(Icons.more_vert, color: Theme.of(context).textTheme.title.color,),
            onPressed: () => print('Hola'),
          ),
        ],

        leading: leading ?? new IconButton(icon: new Icon(Icons.subject,
          color: Theme.of(context).textTheme.title.color,),
          onPressed: () => scaffoldKey.currentState.openDrawer()
        ),
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
  final double height;

  MyInput({Key key, this.label, this.hint, this.obscureText, this.menu,
    this.keyText, this.fontSize,
      this.align, this.fontW, this.color, @required this.height}): super(key: key);

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

        new TextContainer(label, color: Colors.blue,
          align: TextAlign.left, fontSize: 12.0, contAlign: Alignment.bottomLeft,
          bottom: 6.0,
        ),

        new Container(
          margin: EdgeInsets.only(bottom: 10.0),
          alignment: Alignment.center,
          height: height,
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Colors.blue.shade200,
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
    final Size size = MediaQuery.of(context).size;
    final boxHeight = size.height * 0.25;

    final topPadding = (appbar == null || !appbar) ? boxHeight * 0.35 : boxHeight * 0.15;

    final betweenPadding = size.height * 0.03;
    final hPadding = size.width * 0.10;


    final bottomPadding = boxHeight * 0.1;

    //print('topPaading: ${topPadding} -- betweenPadding: ${betweenPadding} -- screenHeight: ${screenSize.height}');

    return new Container(

      constraints: new BoxConstraints.expand(height: boxHeight),
      padding: EdgeInsets.only(top: topPadding) +
        EdgeInsets.symmetric(horizontal: hPadding),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          (title != null) ? new Text(title, style: Theme.of(context).textTheme.headline)
              : new Text(''),
          (title != null) ? new Padding(padding: EdgeInsets.only(top: betweenPadding))
              : new Text(''),
          new Text(subtitle, style: Theme.of(context).textTheme.subhead),

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

    } else if(type == 'outline.icon') {
      return new Container(
        width: width, height: height,
        child: new OutlineButton.icon(
          borderSide: new BorderSide(width: 4.0, color: Colors.blue),
          icon: const Icon(Icons.tag_faces, color: Colors.blue,),
          label: new TextContainer(text, fontW: FontWeight.w700, color: Colors.blue,),
          onPressed: () {

          },
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
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



