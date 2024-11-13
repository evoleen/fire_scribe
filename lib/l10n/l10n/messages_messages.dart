// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.
// @dart=2.12
// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'messages';

  static m0(entityType) => "${entityType} ID";

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'allResources': MessageLookupByLibrary.simpleMessage('All resources'),
        'appErrorPageMessage':
            MessageLookupByLibrary.simpleMessage('Error found, please refresh'),
        'appTitle': MessageLookupByLibrary.simpleMessage('Fire Scribe'),
        'bearerToken': MessageLookupByLibrary.simpleMessage('Bearer Token'),
        'bearerTokenFormEmpty': MessageLookupByLibrary.simpleMessage(
            'Please, enter a Bearer token to connect'),
        'connectToServerHelpText': MessageLookupByLibrary.simpleMessage(
            'To view all resources please connect to server.\nCopy and paste the link to your server’s URL above.'),
        'entityTypeIdHeader': m0,
        'introduceBearerToken':
            MessageLookupByLibrary.simpleMessage('Enter Bearer Token'),
        'introduceServerUrl':
            MessageLookupByLibrary.simpleMessage('Enter Server URL'),
        'lastUpdate': MessageLookupByLibrary.simpleMessage('Last update'),
        'loginWithAzureIdentity':
            MessageLookupByLibrary.simpleMessage('Login with Azure Identity'),
        'loginWithBearerToken':
            MessageLookupByLibrary.simpleMessage('Login with Bearer token'),
        'noDataAssociatedToAnEntity': MessageLookupByLibrary.simpleMessage(
            'There\'s no data associated\nwith this entity'),
        'pageComingSoon':
            MessageLookupByLibrary.simpleMessage('Page coming soon'),
        'privacyPolicy': MessageLookupByLibrary.simpleMessage('Privacy Policy'),
        'refresh': MessageLookupByLibrary.simpleMessage('Refresh'),
        'selectAnEntityFromList': MessageLookupByLibrary.simpleMessage(
            'Select an entity to see entries of that type'),
        'server': MessageLookupByLibrary.simpleMessage('Server'),
        'serverConnectedWarning':
            MessageLookupByLibrary.simpleMessage('Connected to server'),
        'serverNotConnectedWarning': MessageLookupByLibrary.simpleMessage(
            'Cannot connect to specified url'),
        'serverUrl': MessageLookupByLibrary.simpleMessage('Server URL'),
        'serverUrlFormEmpty': MessageLookupByLibrary.simpleMessage(
            'Please, add a servel url to connect'),
        'settings': MessageLookupByLibrary.simpleMessage('Settings'),
        'termsOfUse': MessageLookupByLibrary.simpleMessage('Terms Of Use'),
        'thirdPartyLicenses':
            MessageLookupByLibrary.simpleMessage('Third-Party Licenses')
      };
}
