import 'package:flutter/material.dart';
import 'application.dart';
import 'translations.dart';
import 'weed.dart';
import 'regCountry.dart';


class RegBirthdatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegBirthdatePageState();
}

class RegBirthdatePageState extends State<RegBirthdatePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController monthTEC = new TextEditingController();
  TextEditingController dayTEC = new TextEditingController();
  TextEditingController yearTEC = new TextEditingController();

  final List<String> _allCountries = <String>['United States', 'England', 'Australia', 'Guatemala'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double bottomPadding = size.height * 0.075;
    final double hPadding = size.width * 0.1;


    dayTEC.addListener(() {
      setState(() {
        print('${dayTEC.text}');
      });
    });

    return new Scaffold(
        key: _scaffoldKey,
        body: new Stack(children: <Widget>[
          SingleChildScrollView(
            child: new Column(
              children: <Widget>[

                new MyTitle(
                  title: 'Hi '+user.firstName,
                  emoji: '\u{1F44B}',
                  subtitle: T(context, k: 'regdate_lbl2'),
                ),

                new Container(
                  /// It lets the input fields not to be at the edge of the screen.
                    padding: new EdgeInsets.only(bottom: bottomPadding)
                        + EdgeInsets.symmetric(horizontal: hPadding, vertical: size.height * 0.1),
                    constraints: new BoxConstraints.expand(
                      height: size.height * 0.6,
                    ),

                    child: new Form(

                      key: this._formKey,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          new Text(T(context, k: 'regdate_lbl3'),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.normal)),

                          new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new MyInput(label: T(context, k: 'regdate_lbl5'), hint: 'March',
                                  controller: monthTEC, menu: true, width: size.width * 0.28,),
                                new MyInput(label: T(context, k: 'regdate_lbl6'), hint: '27',
                                  controller: dayTEC, width: size.width * 0.16,),
                                new MyInput(label: T(context, k: 'regdate_lbl7'), hint: '1960',
                                  controller: yearTEC, width: size.width * 0.24,),
                              ],
                            ),
                          ),

                          new Text(T(context, k: 'regdate_lbl4'),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.body1),



                        ],),
                    )
                ),


              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            margin: EdgeInsets.only(top: size.height * 0.85),
            alignment: Alignment.center,
            constraints: new BoxConstraints.expand(
              height: size.height * 0.15,
            ),
            decoration: new BoxDecoration(
              color: Colors.blue.shade50,
            ),
            child: new MyButton(text: 'CONTINUE', type: 'raised',
              width: size.width,
              widget: new RegCountryPage(),),
          ),


        ],)


    );
    //Translations.of(context).locale.languageCode,
  }
}
