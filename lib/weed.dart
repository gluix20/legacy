import 'package:flutter/material.dart';
import 'topics.dart';



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
  final Color color;

  MyAppBar(this.text, {Key key, @required this.context,
    this.scaffoldKey, this.actions, this.leading, this.color}) :

        super(key: key,
        elevation: 0.0,
        backgroundColor: color ?? Colors.white30,
        title: new Text(text, style: Theme.of(context).textTheme.title,),
        centerTitle: true,


        actions: actions ?? <Widget>[
          new IconButton(
            icon: new Icon(Icons.more_vert,
          color: Theme.of(context).textTheme.title.color,),
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
  final TextEditingController controller;
  final FocusNode focusNode;

  MyInput({Key key, this.label, this.hint, this.obscureText, this.menu,
    this.keyText, this.fontSize,
    this.align, this.fontW, this.color,
    this.height, this.controller, this.focusNode}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = this.height ?? size.height * 0.065;

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
          padding: EdgeInsets.only(bottom: size.height * 0.005),
          child: new Text(label, style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12.0),),
        ),

        new Container(
          margin: EdgeInsets.only(bottom: size.height * 0.015),
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
            maxLines: 1,
            controller: controller ?? new TextEditingController(),
            focusNode: focusNode ?? new FocusNode(),
            obscureText: obscureText ?? false,
            decoration: new InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.03),
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
  final TextAlign align;
  final FontWeight fontW;
  final Color color;
  final String type;
  final double height;
  final double width;
  final Widget widget;
  final Function func;

  MyButton({@required this.text, this.align, this.fontW, this.color,
    @required this.type, @required this.width, this.widget,
    this.height,
    this.func,
  }) : super();

  void actionPush(BuildContext context) {
    Navigator.push( context,
        new MaterialPageRoute(builder: (context) => widget));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = this.height ?? size.height * 0.065;

    final borderShape = new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0));

    if(type == 'outline') {
      return new OutlineButton(
        child: new Container(width: width, height: height, alignment: Alignment.center,
            child: new Text(text, style: Theme.of(context).textTheme.button,)),
        onPressed: () {
          if(widget != null) {
            actionPush(context);
          } else {
            func();
          }
        },
        color: Colors.white,
        shape: borderShape,
        borderSide: new BorderSide(width: 4.0, color: Colors.blue.shade100),
      );

    } else if(type == 'raised') {
      return new RaisedButton(
        child: new Container(width: width, height: height, alignment: Alignment.center,
            child: new Text(text, style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),)),
        onPressed: () {
          if(widget != null) {
            actionPush(context);
          } else {
            func();
          }
        },
        shape: borderShape,
        elevation: 0.0,
        color: Colors.blue,
        //disabledColor: Colors.white,
      );

    } else if(type == 'outline.icon') {
      return new Container(
        width: width, height: height,
        child: new OutlineButton.icon(
          borderSide: new BorderSide(width: 4.0, color: Colors.blue),
          icon: const Icon(Icons.tag_faces, color: Colors.blue,),
          label: new Text(text, style: Theme.of(context).textTheme.button,),
          onPressed: () {
            func();
          },
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      );
    }
    return Text('Weed: No button was called.');


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

    int index= 0;

    return new Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.blue,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.white,
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.blue.shade200))),


      child: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(icon: new Icon(Icons.menu, ), title: new Text('')),
          new BottomNavigationBarItem(icon: new Icon(Icons.edit, ), title: new Text('')),
          new BottomNavigationBarItem(icon: new Icon(Icons.person, ), title: new Text('')),
        ],
        currentIndex: index,
        onTap: (int i){ setState((){index = i;});},
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

}



