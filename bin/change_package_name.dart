// #!/usr/bin/env dart

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

Future<void> main(List<String> args) async {
  const defaultAppName = 'flutter_fastapp';
  const defaultPackageName = 'com.example.flutter_fastapp';

  final argParser = ArgParser()
    ..addOption(
      'app_name',
      mandatory: true,
      help: 'New app name',
    )
    ..addOption(
      'package_name',
      mandatory: true,
      help: 'New package name',
    );

  ArgResults prettyArgs;
  try {
    prettyArgs = argParser.parse(args);
  } catch (ex) {
    print(ex.toString());
    print('');
    print(argParser.usage);
    return;
  }

  final packageName = prettyArgs['package_name'] as String;
  await changeAndroidPackage(defaultPackageName, packageName);
  await searchAndReplace(
    defaultPackageName,
    packageName,
    Directory('.'),
  );

  final appName = prettyArgs['app_name'] as String;
  await replaceInPubspec('name', appName);
  await replaceInPubspec('description', '"$appName"');
  await searchAndReplace(
    defaultAppName,
    appName,
    Directory('./lib'),
  );
}

Future<void> copyDirectory(Directory source, Directory destination) async {
  if (!await destination.exists()) {
    await destination.create(recursive: true);
  }

  await for (var entity in source.list()) {
    final newpath = path.join(destination.path, path.basename(entity.path));
    print('entity: ${entity.path} newpath: $newpath');
    if (entity is File) {
      await entity.copy(newpath);
    } else if (entity is Directory) {
      await copyDirectory(entity, Directory(newpath));
    }
  }
}

Future<void> changeAndroidPackage(String searchText, String replaceText) async {
  final androidPackageRootFolder = Directory('./android/app/src/main/kotlin/');
  final currentAndroidFolder = Directory(
    path.join(
      androidPackageRootFolder.path,
      'com/example/flutter_fastapp',
    ),
  );
  final newAndroidFolder = Directory(
    path.join(
      androidPackageRootFolder.path,
      replaceText.replaceAll('.', '/'),
    ),
  );
  await copyDirectory(currentAndroidFolder, newAndroidFolder);
  await currentAndroidFolder.delete();
}

Future<void> searchAndReplace(
  String searchText,
  String replaceText,
  Directory directory,
) async {
  directory.listSync(recursive: true).whereType<File>().forEach(
    (file) async {
      if (file.path != './bin/change_package_name.dart') {
        try {
          final content = await file.readAsString();
          if (content.contains(searchText)) {
            final updatedContent = content.replaceAll(searchText, replaceText);
            await file.writeAsString(updatedContent);
            print('Replaced in ${file.path}');
          }
        } catch (_) {}
      }
    },
  );
}

Future<void> replaceInPubspec(String field, String replaceString) async {
  final file = File('./pubspec.yaml');
  var lines = await file.readAsLines();

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith(field)) {
      if (replaceString.isNotEmpty) {
        lines[i] = '$field: $replaceString';
      } else {
        lines[i] = '';
      }
      break;
    }
  }

  lines.removeWhere((element) => element.isEmpty);
  await file.writeAsString(lines.join('\n'));
  print('Replace pubspec.yaml $field to $replaceString');
}
