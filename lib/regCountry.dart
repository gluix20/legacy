import 'package:flutter/material.dart';
import 'translations.dart';
import 'weed.dart';
import 'topics.dart';
import 'application.dart';


class RegCountryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegCountryPageState();
}

class RegCountryPageState extends State<RegCountryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController countryTEC = new TextEditingController();
  TextEditingController stateTEC = new TextEditingController();
  TextEditingController cityTEC = new TextEditingController();

  final List<String> _allCountries = <String>['United States', 'England', 'Australia', 'Guatemala'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double bottomPadding = size.height * 0.075;
    final double hPadding = size.width * 0.1;

    return new Scaffold(
      key: _scaffoldKey,
      body: new Stack(children: <Widget>[
      SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new MyTitle(
              title: T(context, k: 'regcountry_lbl1')+'60'+'\'s! '+
                  T(context, k: 'regcountry_lbl2'),
              emoji: '\u{1F64C}',
              subtitle: T(context, k: 'regcountry_lbl3'),
            ),

            new Container(
              /// It lets the input fields not to be at the edge of the screen.
              padding: new EdgeInsets.only(bottom: bottomPadding)
                  + EdgeInsets.symmetric(horizontal: hPadding),
              constraints: new BoxConstraints.expand(
                height: size.height * 0.6,
              ),

              child: new Form(

                key: this._formKey,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Text(T(context, k: 'regcountry_lbl4'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.normal)),

                    new Column(
                      children: <Widget>[
                        new MyInput(label: 'Country/Region', hint: 'United States', controller: countryTEC,
                            menu: true, type: 'menu', allValues: _allCountries,),
                        new MyInput(label: 'State', hint: 'California', controller: stateTEC,
                            menu: true),
                        new MyInput(label: 'City', hint: 'Roseville', controller: cityTEC,
                            menu: true),
                      ],
                    ),

                    new Text(T(context, k: 'regcountry_lbl5'),
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
          widget: new TopicsPage(),),
      ),
      ],)
    );
    //Translations.of(context).locale.languageCode,
  }
}
