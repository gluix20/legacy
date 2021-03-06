import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

typedef void LocaleChangeCallback(Locale locale);

final FacebookLogin facebookSignIn = new FacebookLogin();
FacebookLoginResult result;

class APPLIC {
  // List of supported languages
  final List<String> supportedLanguages = ['en','es'];
  // Returns the list of supported Locales
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));
  // Function to be invoked when changing the working language
  LocaleChangeCallback onLocaleChanged;

  ///
  /// Internals
  ///
  static final APPLIC _applic = new APPLIC._internal();

  factory APPLIC(){
    return _applic;
  }

  APPLIC._internal();

  static String paragraph = '';
  static void appendP(String s) {
    paragraph = paragraph + s;
  }

  static String getP() {
    return paragraph;
  }

}

APPLIC applic = new APPLIC();


class User {
  // Function to be invoked when changing the working language
  //LocaleChangeCallback onLocaleChanged;
  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  String token;
  String country;
  String state;
  String city;
  String dateBirth;
  Locale locale;
  String fullName;

  static final User _user = new User._internal();

  factory User({int id, String firstName, String lastName, String fullName, String email,
  String country, String state, String city, String dateBirth}){
    _user.id = id == null? _user.id : id;
    _user.firstName = firstName == null? _user.firstName : firstName;
    _user.lastName = lastName == null? _user.lastName : lastName;
    _user.fullName = fullName ?? _user.fullName;
    _user.email = email ?? _user.email;
    _user.country = country ?? _user.country;
    _user.state = state ?? _user.state;
    _user.city = city ?? _user.city;
    _user.dateBirth = dateBirth ?? _user.dateBirth;
    return _user;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    _user.id = json['user'][0]['id'];
    _user.firstName = json['user'][0]['name'];
    _user.lastName = json['user'][0]['last name'];
    return _user;
  }

  User._internal();
}
User user = new User();

Future<User> fetchUser() async {
  final response =
  await http.get('https://my-json-server.typicode.com/gluix20/treasure/db');
  //await http.get('http://192.168.15.133:3000/db');
  final responseJson = json.decode(response.body);
  print(responseJson);

  return new User.fromJson(responseJson);
}

class Question {

  int id;
  String text;
  String category;
  String subCategory;
  String age;
  String answer;
  int skipped;

  bool isAnswered() => this.answer != null;
  bool isSkipped() => this.skipped == 1;

  Question({this.id, this.text, this.category, this.subCategory, this.age, this.answer, this.skipped});
}

List<Question> questions = new List<Question>();
Future<List<Question>> fetchQuestions({String topic, String age}) async {

  final response =
  //await http.get('http://10.0.2.2:3000/db');
  await http.get('https://my-json-server.typicode.com/gluix20/treasure/db');
  final responseJson = json.decode(response.body);
  /// This method it's called every time the TopicPage it's build
  /// but with the line below, the list of questions are reinitiallized.
  ///
  questions = new List<Question>();
  for (var q in responseJson['questions']) {

    if( (topic == q['category'] || topic == null) &&
        (age == q['age'] || age == null)
    ) {
      Question newQ = new Question(
        id: q['id'],
        text: q['text'],
        category: q['category'],
        subCategory: q['subcategory'],
        age: q['age'],
        answer: q['answer'],
        skipped: q['skipped'],
      );
      questions.add(newQ);
    }
  }
  return questions;
}

/// Review PUT requests!!!!
Future<http.Response> putQuestion(int id) async {
  Map jsonData = {
    'skipped' : '1'
  };
  //String jsonString = json.encode(jsonData);

  final response =
  //await http.get('http://10.0.2.2:3000/db');
  await http.put('http://192.168.15.133:3000/questions/1', body: jsonData);
  final responseJson = json.decode(response.body);

  print(responseJson);

  return response;
}