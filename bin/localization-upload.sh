#!/usr/bin/env sh

# Exit on first failed command
set -e 

# Variables
LOCO_API_KEY=""
APP_LOCALIZATIONS_PATH="lib/l10n/app_localizations.dart"
OUTPUT_PATH="lib/l10n/l10n"
DELETE_ABSENT="true"

# Create directory for output if it doesn't exist yet
if [ ! -d $OUTPUT_PATH ]
then
    mkdir $OUTPUT_PATH
fi

# Generate .arb files
fvm dart run intl_translation:extract_to_arb --output-dir=$OUTPUT_PATH $APP_LOCALIZATIONS_PATH

# Upload generated arb to Localise
curl -f -s --data-binary "@$OUTPUT_PATH/intl_messages.arb" "https://localise.biz/api/import/arb?async=true&index=id&locale=en&delete-absent=$DELETE_ABSENT&key=$LOCO_API_KEY"
