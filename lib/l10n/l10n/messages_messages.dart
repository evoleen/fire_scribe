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

  static m0(resourceType) => "Create new ${resourceType}";

  static m1(entityType) => "${entityType} ID";

  static m2(error) => "Invalid JSON Format: ${error}";

  static m3(resourceType, resourceId) =>
      "${resourceType} ${resourceId} created succesfuly";

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'allResources': MessageLookupByLibrary.simpleMessage('All resources'),
        'appErrorPageMessage': MessageLookupByLibrary.simpleMessage(
            'Internal error, refresh the page or restart the app.'),
        'appTitle': MessageLookupByLibrary.simpleMessage('Fire Scribe'),
        'bearerToken': MessageLookupByLibrary.simpleMessage('Bearer Token'),
        'bearerTokenFormEmpty': MessageLookupByLibrary.simpleMessage(
            'Enter a Bearer token to connect'),
        'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
        'connectToServerHelpText': MessageLookupByLibrary.simpleMessage(
            'Connect to the server to view all resources.\nCopy and paste the link to your server\'s URL above.'),
        'createNewResource': m0,
        'entityTypeIdHeader': m1,
        'errorWhenUpdatingResource': MessageLookupByLibrary.simpleMessage(
            'Error when updating resource, please try again'),
        'introduceBearerToken':
            MessageLookupByLibrary.simpleMessage('Enter Bearer Token'),
        'introduceServerUrl':
            MessageLookupByLibrary.simpleMessage('Enter Server URL'),
        'invalidFhirJsonFormat':
            MessageLookupByLibrary.simpleMessage('Invalid FHIR JSON Format'),
        'invalidJsonFormat': m2,
        'lastUpdate': MessageLookupByLibrary.simpleMessage('Last update'),
        'license': MessageLookupByLibrary.simpleMessage(
            'MIT License\nCopyright (c) 2024 Evoleen Technology GmbH\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n'),
        'loginWithAzureIdentity':
            MessageLookupByLibrary.simpleMessage('Login with Azure Identity'),
        'loginWithBearerToken':
            MessageLookupByLibrary.simpleMessage('Login with Bearer token'),
        'noData': MessageLookupByLibrary.simpleMessage('--'),
        'noDataAssociatedToAnEntity': MessageLookupByLibrary.simpleMessage(
            'There\'s no data associated\nwith this entity'),
        'pageComingSoon':
            MessageLookupByLibrary.simpleMessage('Page coming soon'),
        'proceed': MessageLookupByLibrary.simpleMessage('Continue'),
        'refresh': MessageLookupByLibrary.simpleMessage('Refresh'),
        'resourceCreationSuccessful': m3,
        'saveChanges': MessageLookupByLibrary.simpleMessage('Save changes'),
        'selectAnEntityFromList': MessageLookupByLibrary.simpleMessage(
            'Select an entity to see entries of that type'),
        'server': MessageLookupByLibrary.simpleMessage('Server'),
        'serverConnectedWarning':
            MessageLookupByLibrary.simpleMessage('Connected to server'),
        'serverNotConnectedWarning': MessageLookupByLibrary.simpleMessage(
            'Cannot connect to specified URL'),
        'serverUrl': MessageLookupByLibrary.simpleMessage('Server URL'),
        'serverUrlFormEmpty': MessageLookupByLibrary.simpleMessage(
            'Enter the URL of the server to connect before proceeding.'),
        'thirdPartyLicenses':
            MessageLookupByLibrary.simpleMessage('Third-Party Licenses'),
        'warning': MessageLookupByLibrary.simpleMessage('Warning'),
        'warningResourceIdChanged': MessageLookupByLibrary.simpleMessage(
            'The resource\'s id was modified, the update will be saved as new resource or be rejected by the server.\nDo you want to continue?'),
        'warningResourceTypeChanged': MessageLookupByLibrary.simpleMessage(
            'The resource\'s type was modified, the update will be saved as new resource or be rejected by the server.\nDo you want to continue?')
      };
}
