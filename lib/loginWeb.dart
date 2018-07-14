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


class LoginWebPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Size size;
  String _message = '';
  String selectedUrl = "https://tatalapp.auth.us-east-1.amazoncognito.com/login?response_type=token&client_id=1b8lp4s364i5io3as6umpbmm4u&redirect_uri=https://twitter.com";

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    flutterWebviewPlugin.launch(selectedUrl,
        rect: new Rect.fromLTWH(
        0.0, 0.0, MediaQuery.of(context).size.width, 300.0),


    );
    return new WebviewScaffold(

      url: selectedUrl,
      appBar: new AppBar(
        title: new Text("Widget webview"),
      ),
      withZoom: true,
      withLocalStorage: true,
    );
    //Translations.of(context).locale.languageCode,
  }
}
