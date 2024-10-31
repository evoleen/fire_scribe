// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:firearrow_admin_app/l10n/app_localizations_delegate.dart';
import 'package:firearrow_admin_app/l10n/l10n/messages_all.dart';
import 'package:firearrow_admin_app/l10n/supported_locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class S {
  /// Initialize localization systems and messages
  static Future<S> load(final Locale locale) async {
    // If we're given "en_US", we'll use it as-is. If we're
    // given "en", we extract it and use it.
    final localeName = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();

    // We make sure the locale name is in the right format e.g.
    // converting "en-US" to "en_US".
    final canonicalLocaleName = Intl.canonicalizedLocale(localeName);

    // Load localized messages for the current locale.
    await initializeMessages(canonicalLocaleName);

    // Initialize Intl Date Formatting
    await initializeDateFormatting(canonicalLocaleName);

    // Force the locale in Intl.
    Intl.defaultLocale = canonicalLocaleName;

    return S();
  }

  /// Retrieve localization resources for the widget tree
  /// corresponding to the given `context`
  static S of(final BuildContext context) {
    return Localizations.of<S>(context, S) ?? S();
  }

  static List<LocalizationsDelegate> get delegates => [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  static String? getLocalizedString(final BuiltMap<String, String> data) {
    //
    // First check the full locale including region to enable
    // differentiation between de_DE and de_CH for example.
    //
    if (data.keys.contains(Intl.defaultLocale)) {
      return data[Intl.defaultLocale];
    }

    //
    // As a fallback, retrieve the string by language lookup.
    // (de, en, it, ...)
    //
    final shortLocale = Intl.defaultLocale?.substring(0, 2) ??
        supportedLocales.first.languageCode;
    if (data.keys.contains(shortLocale)) {
      return data[shortLocale];
    }

    //
    // If that also doesn't work, look for "en"
    //
    if (data.keys.contains('en')) {
      return data['en'];
    }

    //
    // If no match was found, return an empty string to prevent unexpected crashes.
    //
    return '';
  }

  String get appTitle => Intl.message(
        'Firearrow Admin App',
        name: 'appTitle',
      );

  String get appErrorPageMessage => Intl.message(
        'Error found, please refresh',
        name: 'appErrorPageMessage',
      );

  String get refresh => Intl.message(
        'Refresh',
        name: 'refresh',
      );

  String get allResources => Intl.message(
        'All resources',
        name: 'allResources',
      );

  String get serverUrl => Intl.message(
        'Server URL',
        name: 'serverUrl',
      );

  String get introduceServerUrl => Intl.message(
        'Enter Server URL',
        name: 'introduceServerUrl',
      );

  String get serverConnectedWarning => Intl.message(
        'Connected to server',
        name: 'serverConnectedWarning',
      );

  String get serverNotConnectedWarning => Intl.message(
        'Cannot connect to specified url',
        name: 'serverNotConnectedWarning',
      );

  String get connectToServerHelpText => Intl.message(
        '''To view all resources please connect to server.
Copy and paste the link to your server’s URL above.''',
        name: 'connectToServerHelpText',
      );

  String get server => Intl.message(
        'Server',
        name: 'server',
      );

  String get settings => Intl.message(
        'Settings',
        name: 'settings',
      );

  String get privacyPolicy => Intl.message(
        'Privacy Policy',
        name: 'privacyPolicy',
      );

  String get termsOfUse => Intl.message(
        'Terms Of Use',
        name: 'termsOfUse',
      );

  String get thirdPartyLicenses => Intl.message(
        'Third-Party Licenses',
        name: 'thirdPartyLicenses',
      );
}
