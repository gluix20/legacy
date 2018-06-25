import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'prefs.dart';
import 'dart:async';
import 'login.dart';
import 'splash.dart';
import 'translations.dart';
import 'application.dart';
import 'tutorial.dart';
import 'regCountry.dart';
import 'topics.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _localeOverrideDelegate;



  @override
  void initState(){
    super.initState();

    Prefs.init();

    /// Review this line:
    user.firstName = 'Nate';

    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;

    /// With this code it's possible to change the language.
    /// Tested:
     applic.onLocaleChanged(new Locale('en',''));
  }

  @override
  void dispose() {
    Prefs.dispose();
    super.dispose();
  }

  onLocaleChange(Locale locale){
    setState((){
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// This context has not translations, size and defined Theme.
    /// These are the validations:
    ///

    return new MaterialApp(

      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        /// This one manage the circle and progress bar color.
        accentColor: Colors.blue,
        primaryColor: Colors.blue,
        fontFamily: 'Arial',

        textTheme: new TextTheme(
          body1: new TextStyle(color: Colors.blue,
              fontSize: 16.0, fontWeight: FontWeight.normal),
          body2: new TextStyle(color: Colors.blue,
              fontSize: 16.0, fontWeight: FontWeight.w700),
          title: new TextStyle(color: Colors.blue,
            fontSize: 20.0, fontWeight: FontWeight.w700),
          headline:  new TextStyle(color: Colors.blue,
              fontSize: 24.0, fontWeight: FontWeight.w700),
          subhead: new TextStyle(color: Colors.blue,
              fontSize: 18.0, fontWeight: FontWeight.normal),

          display1: new TextStyle(color: Colors.blue,
              fontSize: 24.0, fontWeight: FontWeight.normal, fontFamily: 'Times'),
          display2: new TextStyle(color: Colors.blue,
              fontSize: 36.0, fontWeight: FontWeight.w700),
          display3: new TextStyle(color: Colors.blue,
              fontSize: 44.0, fontWeight: FontWeight.normal),


          button: new TextStyle(color: Colors.blue,
              fontWeight: FontWeight.w700),
          caption: new TextStyle(color: Colors.blue,
              fontSize: 14.0, fontWeight: FontWeight.w700),

        ),

        iconTheme: new IconThemeData(color: Colors.blue),
        //primaryColor: Colors.blue,
        //buttonColor: Colors.blue,

        hintColor: Colors.blue,

        inputDecorationTheme: new InputDecorationTheme(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 5.0, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(const Radius.circular(0.0),),
          ),
        ),


      ),
      title: 'Treasure',
      supportedLocales: applic.supportedLocales(),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      /// To remove the banner uncomment this:
      /// debugShowCheckedModeBanner: false,
      ///
      //home: new LoginPage(),
      //home: new StoriesPage(),
      //home: new IntroPage(),
      home: new SplashPage(),

    );
  }
}