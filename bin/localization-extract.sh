#!/bin/sh
# This script extracts all messages from the application and prepares
# the input for translation. Output is lib/l10n/intl_messages.dart.
#
# Create a copy of intl_messages.dart for each locale (intl_en.dart, intl_de.dart),
# denote the corresponding locale in the file and translate them.
#
# After translation, use ./bin/localization-generate.sh to prepare the app locale.
#
dart run intl_generator:extract_to_arb --output-dir=lib/l10n/l10n lib/l10n/app_localizations.dart
