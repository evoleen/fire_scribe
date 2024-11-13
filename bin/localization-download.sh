#!/usr/bin/env sh

# Exit on first failed command
set -e 

# Variables
LOCO_API_KEY=""
APP_LOCALIZATIONS_PATH="lib/l10n/app_localizations.dart"
OUTPUT_PATH="lib/l10n/l10n"

# Create directory for output if it doesn't exist yet
if [ ! -d $OUTPUT_PATH ]
then
    mkdir $OUTPUT_PATH
fi

# Export translations from Loco
curl -f -s -o "localise-translated.zip" "https://localise.biz/api/export/archive/arb.zip?key=$LOCO_API_KEY"
unzip -qq -o -j -d "$OUTPUT_PATH" "localise-translated.zip" 

# Generate Dart files with translations
fvm dart run intl_translation:generate_from_arb "$APP_LOCALIZATIONS_PATH" \
    --output-dir="$OUTPUT_PATH" \
    --codegen_mode debug \
    $OUTPUT_PATH/intl_messages*.arb

# Cleanup
rm "$OUTPUT_PATH/README.txt"
rm "localise-translated.zip"