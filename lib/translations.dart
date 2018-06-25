import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;


import 'application.dart';

class Translations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  //static BuildContext context;

  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }


  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}

String T(BuildContext context, {String t, String k}){
    return t ?? Translations.of(context).text(k);
}

TextSpan textManager(List<TextPair> concat, {TextStyle style}) {
  ///O un map para saber como manejar los styles y los idiomismos,
  ///por ejemplo 60's en ingles y 60s en español.

  List<TextSpan> children;
  for(var tp in concat){
    if(tp.type == 'translation') {
      children.add(new TextSpan(text: tp.text));
    } else if(tp.type == 'emoji') {
      children.add(new TextSpan(text: tp.text));
    } else if(tp.type == 'variable') {
      children.add(new TextSpan(text: tp.text));
    }
  }
  return new TextSpan(children: children);
}

class TextPair {
  String text;
  String type;
  TextStyle ts;
}