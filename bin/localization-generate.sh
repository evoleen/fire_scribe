#!/bin/sh
# Takes the translated files in the l10n subfolder and generates an app locale.
dart run intl_translation:generate_from_arb lib/l10n/app_localizations.dart \
    --output-dir=lib/l10n/l10n \
    --codegen_mode debug \
    lib/l10n/l10n/intl_messages*.arb