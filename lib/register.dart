import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'translations.dart';
import 'weed.dart';
import 'register2.dart';
import 'application.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Size size;
  double keyboardHeight = 0.0;

  ScrollController scrollController;
  TextEditingController fullNameTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  FocusNode fullNameFN = new FocusNode();
  FocusNode emailFN = new FocusNode();
  FocusNode passwordFN = new FocusNode();

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

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = '';

  FacebookLoginResult result;
  Future<Null> _login() async {
    //facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;

    if( result == null || result.status != FacebookLoginStatus.loggedIn ) {
      result = await facebookSignIn.logInWithReadPermissions(['email']);
    }
    print('RESULT: ${result.status}');

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
        var profile = json.decode(graphResponse.body);

        user = User(fullName: profile['name'],
          email: profile['email'],
          firstName: profile['first_name'],
          lastName: profile['last_name'],
        );
        print(user.fullName);
        fullNameTEC.text = user.fullName;
        emailTEC.text = user.email;

        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 600), () => "1");
  }

  double getPosition(BuildContext context, int i) {

    //if(keyboardHeight == 0.0)
      keyboardHeight = MediaQuery.of(context).viewInsets.bottom / size.height;
    final double sum = 75.0 / 683.4;
    //final double first = 286.0 / 683.4 - keyboardHeight;
      final double first = 4.0 / 683.4;
    return size.height * (first + i * sum);
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    //print('FB API Message: $_message');

    scrollController = new ScrollController();
    scrollController.addListener(() {
      //print(scrollController.position);
    },);



    /// Android
    /// The 75.0 is 0.1097 of percentaje of screen and the keyboard 282.0 is 0.4126
    /// The 4.0 of the first field is 0.0058
    ///



    fullNameFN.addListener(() async {
      if (fullNameFN.hasFocus){
        //if (MediaQuery.of(context).viewInsets.bottom == 0)
          await sleep();

        print('RegisterPage: ${getPosition(context, 0)}');
        print('MediaQueryBottom: ${MediaQuery.of(context).viewInsets.bottom}');
        scrollController.jumpTo(getPosition(context, 0));

      } else if (emailFN.hasFocus || passwordFN.hasFocus){
      } else {
        FocusScope.of(context).requestFocus(emailFN);
      }
    });
    emailFN.addListener(() async {
      if (emailFN.hasFocus){
        //if (MediaQuery.of(context).viewInsets.bottom == 0)
        await sleep();
        scrollController.jumpTo(getPosition(context, 1));
      } else if (fullNameFN.hasFocus || passwordFN.hasFocus){
      } else {
        FocusScope.of(context).requestFocus(passwordFN);
      }
    });
    passwordFN.addListener(() async {
      if (passwordFN.hasFocus){
        //if (MediaQuery.of(context).viewInsets.bottom == 0)
        await sleep();
        print('RegisterPage: ${getPosition(context, 3)}');
        print('MediaQueryBottom3: ${MediaQuery.of(context).viewInsets.bottom}');

        scrollController.jumpTo(getPosition(context, 2));
      }
    });



    final scrollView = SingleChildScrollView(
      controller: scrollController,
      //reverse: true,
      child: new Column(
        children: <Widget>[
          /// This is the title with decoration box in blue.
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
                  /// It lets the input fields not to be at the edge of the screen.
                  padding: new EdgeInsets.only(bottom: size.height * 0.075),
                  constraints: new BoxConstraints.expand(
                    height: size.height * 0.67,
                    width: size.width * 1.0,

                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      new MyButton(text: 'LOGIN WITH FACEBOOK', type: 'outline.icon',
                        width: size.width,
                        func: () {
                          print('RegisterPage: Hola mundo');
                          _login();
                        }),

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

                      new Form(
                        key: this._formKey,
                        child: new Column(
                          children: <Widget>[
                            new MyInput(label: 'Full Name', hint: 'John Doe',
                              controller: fullNameTEC, focusNode: fullNameFN,),
                            new MyInput(label: 'Email', hint: 'johndoe@mail.com',
                              controller: emailTEC, focusNode: emailFN,),
                            new MyInput(label: 'Password', hint: 'Password',
                                controller: passwordTEC, focusNode: passwordFN, obscureText: true),
                          ],
                        ),
                      ),

                      new MyButton(text: 'CONTINUE', type: 'raised',
                        width: size.width,
                        widget: new Register2Page(),
                      ),
                  ],),
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