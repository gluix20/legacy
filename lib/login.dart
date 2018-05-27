import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

import 'welcome.dart';
import 'translations.dart';
import 'weed.dart';
import 'tree.dart';
import 'weather.dart';
import 'application.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    putQuestion(1);

  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //print(context.widget);


    return new Scaffold(
      key: _scaffoldKey,
        body: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: this._formKey,
              child: new ListView(
                children: <Widget>[
                  new TextContainer(
                      'main_title1', 36.0, 60.0, 60.0, TextAlign.center,
                      FontWeight.w700),
                  //Translations.of(context).locale.languageCode,

                  new TextFormField(
                      keyboardType: TextInputType
                          .emailAddress, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: Translations.of(context).text(
                              'email_hint1'),
                          labelText: Translations.of(context).text(
                              'email_lbl1'),
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
                          hintText: Translations.of(context).text('pwd_hint1'),
                          labelText: Translations.of(context).text('pwd_lbl1'),
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

                  new TextContainer(
                      'accept_terms1', 14.0, 0.0, 0.0, TextAlign.center),

                  new Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      child: new TextContainer(
                          'signin_bttn1',
                          14.0,
                          0.0,
                          0.0,
                          TextAlign.center,
                          null,
                          Colors.white),
                      onPressed: () {
                        this.validate();
                        Navigator.push(context,
                          new MaterialPageRoute(
                              builder: (context) => new WelcomePage()),
                        );
                      },
                      color: Colors.blue,
                    ),
                    margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
                  ),

                  new TextContainer(
                      'or_lbl1', 14.0, 0.0, 0.0, TextAlign.center),

                  new Container(
                    width: screenSize.width,
                    child: new OutlineButton(
                      child: new TextContainer(
                          'fb_bttn1', 14.0, 0.0, 0.0, TextAlign.center),
                      onPressed: () {
                        Navigator.push(context,
                          new MaterialPageRoute(
                              builder: (context) => new MyApp()),
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
                  new FlatButton(child: new TextContainer(
                      'signup_bttn1', 14.0, 0.0, 0.0, TextAlign.center),
                    onPressed: () {
                      Navigator.push(context,
                        new MaterialPageRoute(
                            builder: (context) => new TreePage()),
                      );
                    },),
                ],
              ),
            )
        )
    );
  }
}

class _LoginData {
  String email = '';
  String password = '';
}