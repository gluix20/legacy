import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'welcome.dart';
import 'translations.dart';
import 'ball.dart';
import 'application.dart';
import 'weed.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  SpecificLocalizationDelegate _localeOverrideDelegate;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return Translations.of(context).text('email_valid1');
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return Translations.of(context).text('password_valid1');
    }

    return null;
  }

  void validate() {
    // First validate form.
    /*
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
    */

  }



  @override
  void initState(){
    //applic.onLocaleChanged(new Locale('en',''));
    super.initState();

    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;

    /// With this code it's possible to change the language.
    /// Tested.
    /// applic.onLocaleChanged(new Locale('es',''));
  }

  onLocaleChange(Locale locale){
    setState((){
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Here, with this context, we don't the translation context yet,
    /// neither the size of the app.
    ///
    return new MaterialApp(

      theme: new ThemeData(fontFamily: 'Montserrat'),
      title: 'Treasure',
      //onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
      //home: new LoginPage(),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      //debugShowCheckedModeBanner: false,

      home: new Builder(
          builder: (BuildContext context) {
            /// This context has translations, size and defined Theme.
            /// These are the validations:
            ///
            final Size screenSize = MediaQuery.of(context).size;
            final String hola = Translations.of(context).text('main_title1');
            print('Size: $screenSize');
            print('Texto: $hola');

            String getS(String s){
              return Translations.of(context).text(s);
            }

            return new Scaffold(
                body: new Container(
                    padding: new EdgeInsets.all(20.0),
                    child: new Form(
                      key: this._formKey,
                      child: new ListView(
                        children: <Widget>[
                          new TextContainer('main_title1', 36.0, 60.0, 60.0, TextAlign.center, FontWeight.w700),
                          //Translations.of(context).locale.languageCode,

                          new TextFormField(
                              keyboardType: TextInputType
                                  .emailAddress, // Use email input type for emails.
                              decoration: new InputDecoration(
                                  hintText: getS('email_hint1'),
                                  labelText: getS('email_lbl1'),
                                  isDense: true),
                              validator: this._validateEmail,
                              onSaved: (String value) {
                                this._data.email = value;
                              }),
                          new Container(
                            width: screenSize.width,
                            child: new TextFormField(
                              obscureText: true, // Use secure text for passwords.
                              decoration: new InputDecoration(
                                  hintText: getS('pwd_hint1'),
                                  labelText: getS('pwd_lbl1'),
                                  isDense: true),
                              validator: this._validatePassword,
                              onSaved: (String value) {
                                this._data.password = value;
                              },

                            ),
                            margin: new EdgeInsets.only(
                              top: 20.0,
                              bottom: 30.0,
                            ),
                          ),

                          new TextContainer('accept_terms1', 14.0, 0.0, 0.0, TextAlign.center),

                          new Container(
                            width: screenSize.width,
                            child: new RaisedButton(
                              child: new TextContainer('signin_bttn1', 14.0, 0.0, 0.0, TextAlign.center, null, Colors.white),
                              onPressed: () {
                                this.validate();
                                Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) => new WelcomePage()),
                                );
                              },
                              color: Colors.blue,
                            ),
                            margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
                          ),

                          new TextContainer('or_lbl1', 14.0, 0.0, 0.0, TextAlign.center),

                          new Container(
                            width: screenSize.width,
                            child: new OutlineButton(
                              child: new TextContainer('fb_bttn1', 14.0, 0.0, 0.0, TextAlign.center),
                              onPressed: () {
                                Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) => new BallPage()),
                                );
                                },
                              borderSide: new BorderSide(width: 3.0),

                            ),
                            margin: new EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                            ),
                          ),

                          new Divider(height: 16.0),
                          new TextContainer('signup_bttn1', 14.0, 0.0, 0.0, TextAlign.center),

                        ],
                      ),
                    )
                ));
          }
      ),


    );
  }
}

class _LoginData {
  String email = '';
  String password = '';
}