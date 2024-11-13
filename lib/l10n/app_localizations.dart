// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:fire_scribe/l10n/app_localizations_delegate.dart';
import 'package:fire_scribe/l10n/l10n/messages_all.dart';
import 'package:fire_scribe/l10n/supported_locales.dart';
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
        'Fire Scribe',
        name: 'appTitle',
        desc: 'The title of the app',
      );

  String get appErrorPageMessage => Intl.message('Error found, please refresh',
      name: 'appErrorPageMessage',
      desc: 'The message showed when user access to a wrong route');

  String get refresh =>
      Intl.message('Refresh', name: 'refresh', desc: 'Refresh word');

  String get allResources => Intl.message(
        'All resources',
        name: 'allResources',
        desc: 'The title of the entity list section',
      );

  String get serverUrl => Intl.message(
        'Server URL',
        name: 'serverUrl',
        desc: 'The label of the server connection text field',
      );

  String get introduceServerUrl => Intl.message(
        'Enter Server URL',
        name: 'introduceServerUrl',
        desc: 'The hint text of the server connection text field',
      );

  String get serverConnectedWarning => Intl.message(
        'Connected to server',
        name: 'serverConnectedWarning',
        desc: 'Message for showing in a snackbar after a successful connection',
      );

  String get serverNotConnectedWarning => Intl.message(
        'Cannot connect to specified url',
        name: 'serverNotConnectedWarning',
        desc:
            'Message for showing in a snackbar after an unsuccessful connection',
      );

  String get connectToServerHelpText => Intl.message(
        '''To view all resources please connect to server.
Copy and paste the link to your server’s URL above.''',
        name: 'connectToServerHelpText',
        desc:
            'Message showed when the user does not have a valid connection to a server',
      );

  String get noDataAssociatedToAnEntity => Intl.message(
        '''There's no data associated
with this entity''',
        name: 'noDataAssociatedToAnEntity',
        desc:
            'Message showed when no data retrieved from backend for a certcain entity',
      );

  String entityTypeIdHeader(final String entityType) => Intl.message(
        '$entityType ID',
        name: 'entityTypeIdHeader',
        args: [entityType],
        desc: 'ID column for the data viewer',
      );

  String get lastUpdate => Intl.message(
        'Last update',
        name: 'lastUpdate',
        desc: 'Last update column for the data viewer',
      );

  String get selectAnEntityFromList => Intl.message(
        'Select an entity to see entries of that type',
        name: 'selectAnEntityFromList',
        desc:
            'Message showed when user is connected but not selected any entity to display data yet',
      );

  String get pageComingSoon => Intl.message('Page coming soon',
      name: 'pageComingSoon',
      desc: 'Message to show for pages that are not integrated yet');

  String get server => Intl.message(
        'Server',
        name: 'server',
        desc: 'Server menu item label',
      );

  String get settings => Intl.message(
        'Settings',
        name: 'settings',
        desc: 'Settings menu item label',
      );

  String get privacyPolicy => Intl.message(
        'Privacy Policy',
        name: 'privacyPolicy',
        desc: 'Privacy Policy menu item label',
      );

  String get termsOfUse => Intl.message(
        'Terms Of Use',
        name: 'termsOfUse',
        desc: 'Terms of Use menu item label',
      );

  String get thirdPartyLicenses => Intl.message(
        'Third-Party Licenses',
        name: 'thirdPartyLicenses',
        desc: 'third party licenses menu item label',
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
      );
}
