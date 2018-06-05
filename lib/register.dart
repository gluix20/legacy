import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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

  ScrollController scrollController;

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

    scrollController = new ScrollController();
    scrollController.addListener(() {
      print(scrollController.position);
      //if(scrollController.offset > 100.0)
      //scrollController.jumpTo(80.0);
    },);

    final scrollView = SingleChildScrollView(
      controller: scrollController,
      reverse: true,
      child: new Column(
        children: <Widget>[
          /// This is the title with decortion box in blue.
          new Container(
            padding: EdgeInsets.only(bottom: size.height * 0.2 * 0.1),
            alignment: Alignment.bottomCenter,
            constraints: new BoxConstraints.expand(
              height: size.height * 0.2,
            ),
            decoration: new BoxDecoration(
              color: Colors.blue,
            ),
            child: new Text(T(context, k: 'main_title1'),
              style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white),
            ),
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
                  child: new Text(T(context, t: 'Create an account'),
                      style: Theme.of(context).textTheme.headline),
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
                            width: size.width,
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
                              new MyInput(label: 'Full Name', hint: 'John Doe'),
                              new MyInput(label: 'Email', hint: 'johndoe@mail.com'),
                              new MyInput(label: 'Password', hint: 'Password', obscureText: true),
                            ],
                          ),


                          new MyButton(text: 'CONTINUE', type: 'raised',
                            width: size.width,
                            widget: new Register2Page(),),
                        ],),
                    )
                ),


              ],
            ),
          )

        ],
      ),
    );




    return new Scaffold(
      key: _scaffoldKey,
      body: scrollView,
    );
    //Translations.of(context).locale.languageCode,
  }
}

class _LoginData {
  String email = '';
  String password = '';
}