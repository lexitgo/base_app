// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class HelperLocale {
  HelperLocale();

  static HelperLocale? _current;

  static HelperLocale get current {
    assert(_current != null,
        'No instance of HelperLocale was loaded. Try to initialize the HelperLocale delegate before accessing HelperLocale.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<HelperLocale> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = HelperLocale();
      HelperLocale._current = instance;

      return instance;
    });
  }

  static HelperLocale of(BuildContext context) {
    final instance = HelperLocale.maybeOf(context);
    assert(instance != null,
        'No instance of HelperLocale present in the widget tree. Did you add HelperLocale.delegate in localizationsDelegates?');
    return instance!;
  }

  static HelperLocale? maybeOf(BuildContext context) {
    return Localizations.of<HelperLocale>(context, HelperLocale);
  }

  /// `Перейти`
  String get home_goDummy {
    return Intl.message(
      'Перейти',
      name: 'home_goDummy',
      desc: '',
      args: [],
    );
  }

  /// `Главная`
  String get ScreenTitle_Home {
    return Intl.message(
      'Главная',
      name: 'ScreenTitle_Home',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get ScreenTitle_Login {
    return Intl.message(
      'Войти',
      name: 'ScreenTitle_Login',
      desc: '',
      args: [],
    );
  }

  /// `BaseApp`
  String get appName {
    return Intl.message(
      'BaseApp',
      name: 'appName',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<HelperLocale> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<HelperLocale> load(Locale locale) => HelperLocale.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
