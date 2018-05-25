import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

typedef void LocaleChangeCallback(Locale locale);

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
  String name;
  String lastName;
  String email;
  String token;
  String city;
  Locale locale;

  static final User _user = new User._internal();

  factory User({int id, String name, String lastName}){
    _user.id = id == null? _user.id : id;
    _user.name = name == null? _user.name : name;
    _user.lastName = lastName == null? _user.lastName : lastName;
    return _user;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    _user.id = json['user'][0]['id'];
    _user.name = json['user'][0]['name'];
    _user.lastName = json['user'][0]['last name'];
    return _user;
  }

  User._internal();
}
User user = new User();

Future<User> fetchUser() async {
  final response =
  await http.get('http://10.0.2.2:3000/db');
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

  Question({this.id, this.text, this.category, this.subCategory, this.age});
}

List<Question> questions = new List<Question>();

Future<List<Question>> fetchQuestions(String topic) async {
  final response =
  await http.get('http://10.0.2.2:3000/db');
  //await http.get('http://192.168.15.133:3000/db');
  final responseJson = json.decode(response.body);
  /// This method it's called every time the TopicPage it's build
  /// but with the line below, the list of questions are reinitiallized.
  ///
  questions = new List<Question>();
  for (var q in responseJson['questions']) {
    if(topic == q['category']) {
      questions.add(new Question(
          id: q['id'],
          text: q['text'],
          category: q['category'],
          subCategory: q['subcategory'],
          age: q['age']));
    }
    //print(q);
  }
  return questions;
}