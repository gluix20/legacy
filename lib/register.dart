import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

import 'welcome.dart';
import 'translations.dart';
import 'weed.dart';
import 'register2.dart';
import 'application.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
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
    final Size size = MediaQuery.of(context).size;
    //print(context.widget);

    return new Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            /// This is the title with decortion box in blue.
            new Container(
              constraints: new BoxConstraints.expand(
                height: size.height * 0.2,
              ),
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
              child: new TextContainer(T(context, k: 'main_title1'),
                fontSize: 36.0, bottom: size.height * 0.2 * 0.1, fontW: FontWeight.w700,
                color: Colors.white, contAlign: Alignment.bottomCenter,),
            ),
            /// This is the subsequent children that have horizontal padding.
            new Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: new Column(
                children: <Widget>[

                  new Container(
                    alignment: Alignment.center,
                    constraints: new BoxConstraints.expand(
                      height: size.height * 0.13,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white30,
                    ),
                    child: new TextContainer(T(context, t: 'Create an account'),
                        fontSize: 24.0, fontW: FontWeight.w700,
                        color: Colors.blue),
                  ),

                  new Container(
                      constraints: new BoxConstraints.expand(
                        height: size.height * 0.67,
                        width: size.width * 1.0,

                      ),
                      /// It lets the input fields not to be at the edge of the screen.
                      padding: new EdgeInsets.only(bottom: size.height * 0.075),
                      child: new Form(
                        key: this._formKey,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            new MyButton(text: 'LOGIN WITH FACEBOOK', type: 'outline.icon',
                              width: size.width, height: size.height * 0.075,
                              widget: new Register2Page(),),

                            new Container(
                              //margin: EdgeInsets.all(20.0),
                              alignment: Alignment.center,
                              height: 5.0, width: 30.0,
                              decoration: new BoxDecoration(
                                color: Colors.blue.shade100,
                                border: new Border.all(
                                    color: Colors.blue.shade100,
                                    width: 1.0
                                ),
                                borderRadius: new BorderRadius.circular(30.0),

                              ),
                            ),

                            new Column(
                              children: <Widget>[
                                new MyInput(label: 'Full Name', hint: 'John Doe', height: size.height * 0.075),
                                new MyInput(label: 'Email', hint: 'johndoe@mail.com', height: size.height * 0.075),
                                new MyInput(label: 'Password', hint: 'Password', obscureText: true, height: size.height * 0.075),
                              ],
                            ),


                            new MyButton(text: 'CONTINUE', type: 'raised',
                              width: size.width, height: size.height * 0.075,
                              widget: new Register2Page(),),
                          ],),
                      )
                  ),


                ],
              ),
            )

          ],
        ),
      )
    );
    //Translations.of(context).locale.languageCode,
  }
}

class _LoginData {
  String email = '';
  String password = '';
}