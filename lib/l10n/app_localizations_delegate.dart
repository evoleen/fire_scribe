import 'dart:async';

import 'package:fire_scribe/l10n/supported_locales.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationsDelegate();
  @override
  bool isSupported(final Locale locale) => supportedLocales.contains(locale);

  @override
  Future<S> load(final Locale locale) => S.load(locale);

  @override
  bool shouldReload(final LocalizationsDelegate<S> old) => false;
}
