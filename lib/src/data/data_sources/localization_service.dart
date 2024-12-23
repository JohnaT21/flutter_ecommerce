import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Localization {
  Localization(this.locale);

  static final List<String> languages = ["en", "am"];

  final Locale locale;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization)!;
  }

  late Map<String, dynamic> _localizedValues;

  Future getLanguages() async {
    String loadedStrings =
    await rootBundle.loadString("assets/lang/${locale.languageCode}.json");

    Map<String, dynamic> _jsonData = jsonDecode(loadedStrings);

    _localizedValues = _jsonData;
  }

  String getTranslation(String key) {
    return _localizedValues[key]!;
  }

  static const LocalizationsDelegate<Localization> delegate =
  LocalizationDelegate();
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      Localization.languages.contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = Localization(locale);
    await localization.getLanguages();
    return localization;
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}

