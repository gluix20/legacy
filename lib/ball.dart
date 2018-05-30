import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'bar.dart';


class BallPage extends StatefulWidget {
  @override
  BallPageState createState() => new BallPageState();
}

class BallPageState extends State<BallPage> with TickerProviderStateMixin {

  AnimationController animationC;
  double screenHeight;
  double screenWidth;

  int bouncings = 0;
  Duration dur;
  double dy = 0.0;
  int y = 0;

  //ScrollSpringSimulation simulation;
  GravitySimulation simulation2;
  BarTween tween;
  final Color color = Colors.blue;

  @override
  void initState() {
    super.initState();

    dur = new Duration(milliseconds: 400);//Duration of the animationController

    animationC = new AnimationController(lowerBound: 0.0, upperBound: 1.0,
      //value: 0.8,
      duration: dur,
      vsync: this,
    );

    simulation2= new GravitySimulation(
      -9.8, // acceleration, pixels per second per second
      0.0, // starting position, pixels
      1.0, // ending position, pixels
      4.0, // starting velocity, pixels per second
      /// It was so lucky to find the 4.0 velocity, with more it does not work!
      /// Have to try with more height
      /// The original gravity and velocity was -9.8 and 4.0 and its slower than below
      /// Another that works is -19.8 and 6.0.
      /// And 0.0 and 1.0  for starting and ending position, these values has a
      /// relation with the animation lower and upper bounds.

    );

    animationC.addListener(() {
      //print(animationC.value.toStringAsFixed(3));
      dy = tween.evaluate(animationC).dy;
      print(dy);

      this.setState(() {

      });
    });
    /// Initialize the first animation without movement but it gets
    /// the tween.animate to paint the ball since the beginning.
    tween = new BarTween(new Bar.empty(), new Bar.empty());

    /// It is not used.
    /*simulation = ScrollSpringSimulation(
      SpringDescription(
        mass: 2.0,
        stiffness: 1.0,
        damping: 0.2,
      ),
      1.0, // starting position, pixels
      400.0, // ending position, pixels
      0.0, // starting velocity, pixels per second
    );
    */
  }

  void changeData() {
    setState(() {
      Bar begin = new Bar.empty();
      Bar end = new Bar.random(height: screenHeight);

      y = (end.dy).toInt();

/*      if((bouncings > 0) && dy <= 80.0 && dy > 20.0) {
        begin = new Bar.now(dy);
      } */

      if (dy <= 150.0 && dy >= 0.0) {

        final double initial = (dy-20)/(y-20);
        print('Height of next jump: ${y} -- dy ${dy} -- initial ${initial}');

      /*
        if (bouncings > 0) {

          begin = new Bar.now(dy);
          simulation2= new GravitySimulation(-9.8, initial, 1.0, 4.0,);
          new AnimationController(lowerBound: 0.0, upperBound: 1.0,
            value: initial,
            duration: dur,
            vsync: this,
          );


        }*/


        bouncings++;
        tween = new BarTween(begin, end);

        animationC.animateWith(simulation2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Bouncings: $bouncings'),
      ),

      body: new GestureDetector(
        onTap: changeData,

        child: new Column(
          children: <Widget>[
            new Container(

              margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              //height: 620.0,
              child: new Column(
                children: <Widget>[

                  new CustomPaint(
                    size: new Size(screenWidth, screenHeight - 170.0),
                    painter: new BarChartPainter(tween.animate(animationC)),
                  ),
                ],
              ),

              decoration: new BoxDecoration(
                color: Colors.black,
                border: new Border(
                  bottom: createBorderSide(context, color: color),
                ),
              ),
            ),

            //new Text('dy: $dy'),
            //new Text('Bouncings: $bouncings'),
            new Text('Y: $y'),
            //new Text('Y: ${animationC.value.toStringAsFixed(3)}'),

          ],
        ),


      ),

      floatingActionButton: new FloatingActionButton(//elevation: 20.0,
        child: new Icon(Icons.refresh),
        onPressed: refreshB,
      ),

    );
  }

  void refreshB(){
    setState(() {
      bouncings = 0;
    });
  }

  BorderSide createBorderSide(BuildContext context,
      { Color color, double width: 3.0 }) {
    assert(width != null);
    return new BorderSide(
      color: color ?? Theme.of(context).dividerColor,
      width: width,
    );
  }

  @override
  void dispose() {
    animationC.dispose();
    super.dispose();
  }

}