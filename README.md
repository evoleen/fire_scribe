# fastapp
Basic Flutter app template to avoid basic infrasctrure work and make developers based in features

## Getting Started
### Configure Firebase 
1. **Install Firebase CLI:**
- Install the Firebase CLI by following the instructions [here](https://firebase.google.com/docs/cli/).
- Login to Firebase using the following command:
```bash
npm install -g firebase-tools
firebase login
```

2. **Create a Firebase Project:**
- firebase projects:create

3. **Activate FlutterFire CLI:**
- Activate FlutterFire CLI using the following command:
```bash
dart pub global activate flutterfire_cli
```

4. **Add Apps to Your Firebase Project:**
- Add new apps for iOS, Android, and web:
- For Android:
  - Use package name: `com.example.flutter_fastapp`.
- For iOS:
  - Use bundle ID: `com.example.flutter_fastapp`.
- For web:
  - No specific configuration is required.

5. **Enable Authentication Providers:**
- Go to the Authentication section in the Firebase Console.
- Enable Email/Password authentication method.

6. **Configure Firebase Options:**
- Run the following command in example project to configure Firebase options:
```bash
flutterfire configure --project=fastapp-dev --platforms="android,ios,web" --android-package-name=com.example.flutter_fastapp --ios-bundle-id=com.example.flutter_fastapp --overwrite-firebase-options --out=lib/firebase_options.dev.dart
  ```

This command generates `firebase_options.dart` file in the `lib` directory.

### Localizations
AppLocalizations is generated automatically in based to the .arb files contained in lib/l10n. To autogenerate them use:
```dart
fvm dart run intl_utils:generate
```

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

## Development

### Change package name
```bash
$ dart run flutter_fastapp:change_package_name --app_name=myapp --package_name=com.example.myapp
```

**Note:** After run the command, project name will be changed. so next run of all bin scripts should be like
```bash
dart run myapp:XXX ....
```

### Update Flutter version based in .fvmrc
```bash
$ dart run fastapp:update_flutter_version
```

### Release
```bash
dart run fastapp_flutter:release
```