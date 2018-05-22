import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'welcome.dart';
import 'translations.dart';

void main() => runApp(

    new MaterialApp(
      theme: new ThemeData(fontFamily: 'Montserrat'),
      title: 'Treasure',
  //onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
      home: new LoginPage(),

  localizationsDelegates: [
    // ... app-specific localization delegate[s] here
    const TranslationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en', ''), // English
    const Locale('es', ''), // Hebrew
    //const Locale('es', 'GT'), // English
    //const Locale('es', ''), // Hebrew
    // ... other locales the app supports
  ],

    ));

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return getS('email_validation1');
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return getS('password_validation1');
    }

    return null;
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new WelcomeScreen()),
    );
  }

  String getS(String s){
    return Translations.of(context).text(s);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('Login'),
      ),*/
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[

                new Container(
                  width: screenSize.width,
                  child: new Text(

                    //DemoLocalizations.of(context).title,
                    //'TREASURE',
                    getS('main_title1'),
                    //Translations.of(context).locale.languageCode,


                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 36.0,
                        //fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700),
                  ),
                  margin: new EdgeInsets.only(top: 60.0, bottom: 60.0),
                ),

                new TextFormField(
                    keyboardType: TextInputType
                        .emailAddress, // Use email input type for emails.
                    decoration: new InputDecoration(
                        hintText: getS('email_example1'), labelText: 'Email', isDense: true),
                    validator: this._validateEmail,
                    onSaved: (String value) {
                      this._data.email = value;
                    }),
            new Container(
              width: screenSize.width,
              child:
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password', labelText: 'Password', isDense: true),
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
                new Text(getS('accept_terms1'),
                    textAlign: TextAlign.center, ),

                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(getS('sign_in_button'),
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),
                new Text(getS('or_label'), textAlign: TextAlign.center),


                new Container(
                  width: screenSize.width,
                  child: new OutlineButton(
                    child: new Text(
                      getS('fb_button'),
                      //style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: this.submit,
                    //color: Colors.blue,
                    borderSide: new BorderSide(width: 3.0),


                  ),
                  margin: new EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                  ),
                ),

                new Divider(height: 16.0, ),

                new Text(getS('not_reg_yet'),
                    textAlign: TextAlign.center),
              ],
            ),
          )),
    );
  }
}



