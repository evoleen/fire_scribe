# Fire Scribe
Database viewer/editor for FHIR server. Currently targeting Azure Health Data Services.

<img width="1146" alt="Screenshot 2025-04-01 at 21 31 44" src="https://github.com/user-attachments/assets/7273c1dc-9dee-4485-b4d6-202ebf5243bd" />
<img width="1146" alt="Screenshot 2025-04-01 at 21 31 50" src="https://github.com/user-attachments/assets/439b98d5-3319-4668-b956-2f466fa63f6f" />

## Localizations

Using https://localise.biz/ as translator manager.

- **bin/localization-extract.sh**: Generates basic intl_messages.arb for checking if all our strings in app_localizations have the right sintax.
- **bin/localization-generate.sh**: Generate string files for the different locales.
- **bin/localization-upload.sh**: Uploads the current strings of app_localizations.dart to Loco
- **bin/localization-download.sh**: Download Loco translations to our project

## Generate third-party license

fvm dart run flutter_oss_licenses:generate && dart format .

### App min assets
#### App icon
Using [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package

For generate round icons for Android we need to do it manually.
- Go to [IconKitchen](https://icon.kitchen/).
- Upload assets/icons/Icon-1024.png
- Select circle and export as ic_launcher_round
- Copy & paste generated files to their respective android/app/src/main/res folders

Run
```
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

#### App splash logo
Using [flutter_native_slpash](https://pub.dev/packages/flutter_native_splash) package

Run
```bash
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

## Release
```bash
dart run fire_scribe:release
```
