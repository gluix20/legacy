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
    final Size screenSize = MediaQuery.of(context).size;
    //print(context.widget);

    return new Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(

        child: new Column(

          children: <Widget>[
          new Container(
            alignment: FractionalOffset.bottomCenter,
            constraints: new BoxConstraints.expand(
              height: screenSize.height * 0.2,
              width: screenSize.width * 1.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.blue,
            ),
            child: new TextContainer(T(context, k: 'main_title1'),
              fontSize: 36.0, bottom: screenSize.height * 0.2 * 0.1, fontW: FontWeight.w700,
            color: Colors.white),
          ),

          new Container(
            alignment: FractionalOffset.center,
            constraints: new BoxConstraints.expand(
              height: screenSize.height * 0.1,
              width: screenSize.width * 1.0,
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
                height: screenSize.height * 0.40,
                width: screenSize.width * 1.0,
              ),
            /// It lets the input fields not to be at the edge of the screen.
            padding: new EdgeInsets.only(top: 10.0, bottom:10.0, left: 40.0, right: 40.0),
            child: new Form(
              key: this._formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                  new MyInput(label: 'Full Name', hint: 'John Doe'),

                  new MyInput(label: 'Email', hint: 'johndoe@mail.com'),

                  new MyInput(label: 'Password', hint: 'Password', obscureText: true,),
            ],),
            )
          ),

          new Container(
            padding: new EdgeInsets.only(top: 10.0, bottom: 40.0, left: 40.0, right: 40.0),
            constraints: new BoxConstraints.expand(
              height: screenSize.height * 0.30,
              width: screenSize.width * 1.0,
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                new Container(
                  width: screenSize.width, height: 50.0,
                  child: new RaisedButton(
                    child: new Text('CONTINUE',
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Register2Page()),
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    disabledElevation: 0.0,
                    color: Colors.blue,
                    disabledColor: Colors.white,

                  ),
                  //margin: new EdgeInsets.only(top: 20.0, bottom: 0.0),
                ),

                //new Padding(padding: EdgeInsets.only(top: 15.0)),

                new Container(

                  //margin: EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  height: 5.0, width: 30.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    border: new Border.all(
                        color: Colors.grey,

                        width: 1.0
                    ),
                    borderRadius: new BorderRadius.circular(30.0),

                  ),
                ),

                //new Padding(padding: EdgeInsets.only(top: 15.0)),

                new Container(
                  width: screenSize.width, height: 50.0,
                  child: new OutlineButton.icon(
                    borderSide: new BorderSide(width: 3.0, color: Colors.blue),
                    icon: const Icon(Icons.tag_faces, color: Colors.blue,),
                    label: new Text('LOGIN WITH FACEBOOK',
                        style: new TextStyle(
                          //color: Colors.white,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    onPressed: () {

                    },
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      )
    );
    //Translations.of(context).locale.languageCode,
  }
}

class _LoginData {
  String email = '';
  String password = '';
}