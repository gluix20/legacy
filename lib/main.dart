import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'login.dart';
import 'splash.dart';
import 'translations.dart';
import 'application.dart';
import 'intro.dart';
import 'register2.dart';
import 'stories.dart';


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
    user.name = 'Nate';
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;

    /// With this code it's possible to change the language.
    /// Tested:
     applic.onLocaleChanged(new Locale('en',''));
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
        fontFamily: 'Montserrat',
        primaryColor: Colors.blue,
        buttonColor: Colors.blue,
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
      home: new SplashPage()
    );
  }
}