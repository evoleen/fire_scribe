// #!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// This script set the flutter version into pubspec.yaml based in the .fmvrc file
void main() {
  // Read the content of the .fvmrc file
  File fvmrcFile = File('.fvmrc');
  if (!fvmrcFile.existsSync()) {
    print('.fvmrc file not found.');
    return;
  }

  String fvmrcContent = fvmrcFile.readAsStringSync();
  Map<String, dynamic> fvmrcJson = jsonDecode(fvmrcContent);
  String flutterVersion = fvmrcJson['flutter'];

  // Update the pubspec.yaml file
  File pubspecFile = File('pubspec.yaml');
  String pubspecContent = pubspecFile.readAsStringSync();

  RegExp flutterVersionRegExp = RegExp(r'flutter: .*$');
  pubspecContent = pubspecContent.replaceAll(
      flutterVersionRegExp, 'flutter: "$flutterVersion"');

  pubspecFile.writeAsStringSync(pubspecContent);

  print('Flutter version updated to $flutterVersion in pubspec.yaml.');
}
