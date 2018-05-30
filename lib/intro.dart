import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'bottom.dart';

class IntroPage extends StatelessWidget {
  final PageController pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    const pages = [
      {
        "title": "Lorem Ipsum One",
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
        "color": Colors.cyan
      },
      {
        "title": "Lorem Ipsum Two",
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
        "color": Colors.lightBlueAccent
      },
      {
        "title": "PLorem Ipsum Three",
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
        "color": Colors.lightGreen
      },
      {
        "title": "PLorem Ipsum Four",
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
        "color": Colors.lightGreen
      }
    ];

    return new Stack(children: [
      PageView.builder(
        controller: pageController,
        itemCount: 4,
        itemBuilder: (context, index) {
          return new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  padding: const EdgeInsets.only(top: 100.0),
                ),

                new FlutterLogo(
                  colors: Colors.blue,
                  size: 170.0,
                ),

                new Container(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 12.0, left: 12.0, right: 12.0),
                  child: new Text(
                    pages[index]['title'],
                    textAlign: TextAlign.center,

                    style: new TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontSize: 44.0,
                      height: 1.1,
                      decoration: TextDecoration.none,
                    ),
                    //textScaleFactor: 0.5,
                  ),
                ),

                new Container(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 100.0, left: 12.0, right: 12.0),
                  child: new Text(
                    pages[index]['text'],
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                        height: 1.2),
                  ),
                ),
              ],
            )
          );
        }
      ),
      new CircleIndicator(
        pageController: pageController,
        size: 4,
      )
    ]);
  }
}

class CircleIndicator extends StatefulWidget {
  final PageController pageController;
  final int size;

  CircleIndicator({Key key, this.pageController, this.size}) : super(key: key);

  @override
  State createState() => new _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator> {
  int position = 0;

  @override
  initState() {
    print('Init Position: ${position} and Init Page ${widget.pageController
        .page}');

    widget.pageController.addListener(() {
      int pageInt = //widget.pageController.page == null? 0 :
          widget.pageController.page?.round();
      print('PageC Position: ${position} and PageC Page ${widget.pageController
          .page}');

      if (pageInt != position) {
        debugPrint("Changed Position from $position to ${pageInt}");
        setState(() {
          position = pageInt;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.bottomCenter,

        padding: EdgeInsets.only(top: 530.0),
        child: new Column(
          children: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicatorList()),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new OutlineButton(

                    child: new Text('SKIP',
                        style: new TextStyle(
                            //color: Colors.white,
                            fontWeight: FontWeight.bold, color: Colors.blue)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new BottomNavigationDemo()),
                      );
                    },
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                borderSide: new BorderSide(width: 4.0, color: Colors.lightBlueAccent),
                    padding: EdgeInsets.only(
                        left: 70.0, right: 70.0, top: 20.0, bottom: 20.0),
                  ),
                  new RaisedButton(
                    child: new Text('NEXT',
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new RegisterPage()),
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    disabledElevation: 0.0,
                    color: Colors.blue,
                    disabledColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 70.0, right: 70.0, top: 20.0, bottom: 20.0),
                  ),
                ],
              ),
              padding: EdgeInsets.only(top: 70.0, bottom: 0.0),
            ),
          ],
        ));
  }

  List<Widget> indicatorList() {
    return new List.generate(
        widget.size,
        (i) =>
            i == position ? drawCircle(Colors.blue) : drawCircle(Colors.grey));
  }

  Widget drawCircle(Color theColor) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(shape: BoxShape.circle, color: theColor),
      width: 8.0,
      height: 8.0,
    );
  }
}
