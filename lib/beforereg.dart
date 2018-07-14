import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'translations.dart';
import 'weed.dart';
import 'regDate.dart';
import 'application.dart';
import 'prefs.dart';


class BeforeRegPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BeforeRegPageState();
}

class _BeforeRegPageState extends State<BeforeRegPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Size size;
  String _message = '';

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
                alignment: Alignment.bottomCenter,
                constraints: new BoxConstraints.expand(
                  height: size.height * 0.30,
                ),
                decoration: new BoxDecoration(
                  color: Colors.white30,
                ),
                child: new Text(T(context, k: 'main_title1'),
                  style: Theme.of(context).textTheme.display2,
                ),
              ),

              new Container(
                alignment: Alignment.topCenter,
                constraints: new BoxConstraints.expand(
                  height: size.height * 0.15,
                ),
                decoration: new BoxDecoration(
                  color: Colors.white30,
                ),
                child: new Text(T(context, k: 'beforereg_lbl1'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title),
              ),

              new Container(
                constraints: new BoxConstraints.expand(
                    height: size.height * 0.3
                ),

                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new MyButton(text: T(context, k: 'fb_bttn1'), type: 'raised',
                      width: size.width,
                        func: () {
                          _login();
                        }
                    ),

                    new Container(
                      alignment: Alignment.topCenter,
                      constraints: new BoxConstraints.expand(
                        height: size.height * 0.05,
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.white30,
                      ),
                      child: new Text(T(context, k: 'beforereg_lbl2'),
                          style: Theme.of(context).textTheme.body1),
                    ),
                    new Container(
                      width: size.width * 0.3,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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

                          new Container(
                            alignment: Alignment.center,
                            constraints: new BoxConstraints(
                              minHeight: size.height * 0.05,
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.white30,
                            ),
                            child: new Text(T(context, k: 'or_lbl1'),
                                style: Theme.of(context).textTheme.title),
                          ),

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
                        ],
                      ),
                    ),



                    new MyButton(text: T(context, k: 'beforereg_bttn2'), type: 'outline',
                        width: size.width,
                        func: () {
                          _login();
                        }
                    ),
                  ],),
              ),
            ],
          ),
        )
    );


    return new Scaffold(
        key: _scaffoldKey,
        body: scrollView,


    );
    //Translations.of(context).locale.languageCode,
  }

  Future<Null> _login() async {
    //facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    if( result == null || result.status != FacebookLoginStatus.loggedIn ) {
      result = await facebookSignIn.logInWithReadPermissions(['email']);
    }
    print('RESULT: ${result.status}');


    Prefs.setString('fbToken', result.accessToken.token).then((bool success) => result.accessToken.token);
    Prefs.setString('fbUserId', result.accessToken.userId).then((bool success) => result.accessToken.userId);
    Prefs.setString('fbExpires', result.accessToken.expires.toString()).then((bool success) => result.accessToken.expires.toString());
    Prefs.setBool('fbLoginStatus', false).then((bool success) => false);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        Prefs.setBool('fbLoginStatus', true).then((bool success) => true);


        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
        var profile = json.decode(graphResponse.body);

        user = User(fullName: profile['name'],
          email: profile['email'],
          firstName: profile['first_name'],
          lastName: profile['last_name'],
        );


        //fullNameTEC.text = user.fullName;
        //emailTEC.text = user.email;

        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');

        //Navigator.push(context,
          //new MaterialPageRoute(builder: (context) => new Register2Page()),
        //);

        Navigator.of(context).push(new PageRouteBuilder(
            opaque: true,
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, _, __) {
              return new RegBirthdatePage();
            },
            transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(
                opacity: animation,
                child: new RotationTransition(
                  turns: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            }
        ));



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

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }
}
