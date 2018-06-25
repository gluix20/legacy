import 'package:flutter/material.dart';
import 'translations.dart';
import 'weed.dart';
import 'beforereg.dart';


class BeforeSubsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BeforeSubsPageState();
}

class _BeforeSubsPageState extends State<BeforeSubsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    final scrollView = SingleChildScrollView(
      child: new Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1) +
            new EdgeInsets.only(bottom: size.height * 0.075),
        child: new Column(
          children: <Widget>[
            /// This is the title with decoration box in blue.
            new Container(
              padding: EdgeInsets.only(bottom: size.height * 0.2 * 0.1),
              alignment: Alignment.bottomLeft,
              constraints: new BoxConstraints.expand(
                height: size.height * 0.25,
              ),
              decoration: new BoxDecoration(
                color: Colors.white30,
              ),
              child: new Text(T(context, k: 'main_title1'),
                style: Theme.of(context).textTheme.display2,
              ),
            ),

            new Container(
              alignment: Alignment.topLeft,
              constraints: new BoxConstraints.expand(
                height: size.height * 0.15,
              ),
              decoration: new BoxDecoration(
                color: Colors.white30,
              ),
              child: new RichText(
                text: new TextSpan(
                  text: T(context, k: 'before_lbl1_1'),
                  style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    new TextSpan(text: T(context, k: 'before_lbl1_2'),
                        style: Theme.of(context).textTheme.title),

                  ],
                ),
              ),
            ),
            new Container(
              alignment: Alignment.topLeft,
              constraints: new BoxConstraints.expand(
                height: size.height * 0.15,
              ),
              decoration: new BoxDecoration(
                color: Colors.white30,
              ),
              child: new Text(T(context, k: 'before_lbl2'),
                  style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.normal)),
            ),

            new Container(
              constraints: new BoxConstraints.expand(
                  height: size.height * 0.5
              ),

              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new MyButton(text: 'START A FREE TRIAL', type: 'raised',
                    width: size.width,
                    widget: new BeforeRegPage(),
                  ),

                  new Container(
                    alignment: Alignment.center,
                    constraints: new BoxConstraints.expand(
                      height: size.height * 0.05,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white30,
                    ),
                    child: new Text(T(context, k: 'before_lbl3'),
                        style: Theme.of(context).textTheme.body1),
                  ),


                  new MyButton(text: 'Log In', type: 'outline',
                      width: size.width,
                      func: () {
                        print('RegisterPage: Hola mundo');

                      }
                  ),

                  new Divider(color: Colors.blue),

                  new Container(
                    alignment: Alignment.topLeft,
                    constraints: new BoxConstraints.expand(
                      height: size.height * 0.05,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white30,
                    ),
                    child: new Text(T(context, k: 'before_lbl4'),
                        style: Theme.of(context).textTheme.body2),
                  ),

                  new Container(
                    alignment: Alignment.topCenter,
                    constraints: new BoxConstraints.expand(
                      height: size.height * 0.2,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white30,
                    ),
                    child: new Text(T(context, k: 'before_lbl5'),
                        style: Theme.of(context).textTheme.body1),
                  ),

                ],),
            ),
          ],
        ),
      )
    );


    return new Scaffold(
      key: _scaffoldKey,
      body: new Stack(children: <Widget>[
        scrollView,
        new Container(
          alignment: Alignment.bottomCenter,
          child: new Container(
            //padding: EdgeInsets.only(bottom: size.height * 0.2 * 0.1),
            alignment: Alignment.center,
            constraints: new BoxConstraints.expand(
              height: size.height * 0.075,
            ),
            decoration: new BoxDecoration(
              color: Colors.blue.shade200,
            ),
            child: new RichText(
              text: new TextSpan(
                text: T(context, k: 'before_lbl6_1'),
                style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.normal),
                children: <TextSpan>[
                  new TextSpan(text: T(context, k: 'before_lbl6_2'),
                      style: Theme.of(context).textTheme.title.copyWith(decoration: TextDecoration.underline)),

                ],
              ),
            ),



          ),
        )

      ],)


    );
    //Translations.of(context).locale.languageCode,
  }
}
