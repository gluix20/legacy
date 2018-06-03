import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'register.dart';
//import 'bottom.dart';
import 'weed.dart';

class IntroPage extends StatelessWidget {
  final PageController pageController = new PageController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    print('screenSize: ${MediaQuery
        .of(context)
        .size}');
    print('pixelRatio: ${MediaQuery
        .of(context)
        .devicePixelRatio}');

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

    return new Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),

      child: new Stack(

          children: [
            PageView.builder(
                controller: pageController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return new Container(
                      padding: EdgeInsets.only(top: size.height * 0.15),
                      child: Column(
                        children: [
                          new Container(
                            constraints: new BoxConstraints.expand(height: size.height * 0.25),
                            child: new FlutterLogo(colors: Colors.blue),
                          ),

                          new Container(
                            constraints: new BoxConstraints(minHeight: size.height * 0.35),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(pages[index]['title'], textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.title,),
                                Text(pages[index]['text'], textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.body1,),
                              ],
                            ),
                          ),
                        ],
                      ));
                }),
            new CircleIndicator(
              pageController: pageController,
              pages: 4,
            )
          ]),
    );
  }
}

class CircleIndicator extends StatefulWidget {
  final PageController pageController;
  final int pages;

  CircleIndicator({Key key, this.pageController, this.pages}) : super(key: key);

  @override
  State createState() => new _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //print('${size.height*0.075}');


    widget.pageController.addListener(() {
      // print('Intro pageController changing: ${widget.pageController.page}');
      if (position != widget.pageController.page?.round() ?? 0) {
        setState(() {
          position = widget.pageController.page?.round() ?? 0;
          print('Intro Indicator Page: ${position+1}');
        });
      }
    });

    return new Container(
        padding: EdgeInsets.only(top: size.height * 0.75, bottom: size.height * 0.075),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicatorList()
            ),

            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  new MyButton(text: 'SKIP', type: 'outline',
                      width: size.width * 0.3, height: size.height * 0.075,
                    //widget: new BottomNavigationDemo(),
                  ),
                  new MyButton(text: 'NEXT', type: 'raised',
                    width: size.width * 0.3, height: size.height * 0.075,
                    widget: new RegisterPage(),),

                ],
              ),
            ),
          ],
        ));
  }

  List<Widget> indicatorList() {
    return new List.generate(
        widget.pages,
        (i) =>
            i == position ? drawCircle(Colors.blue) : drawCircle(Colors.blue.shade50));
  }

  Widget drawCircle(Color color) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(shape: BoxShape.circle, color: color),
      width: 8.0,
      height: 8.0,
    );
  }
}
