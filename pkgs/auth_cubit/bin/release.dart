import 'dart:io';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:pub_semver/pub_semver.dart';

Future<void> main(List<String> args) async {
  final argParser = ArgParser()
    ..addOption(
      'remote',
      defaultsTo: 'origin',
      allowed: ['origin', 'upstream'],
      help: 'Where to push the tag',
    )
    ..addOption(
      'version',
      defaultsTo: 'patch',
      allowed: ['major', 'minor', 'patch'],
      help: '''How to increment to a new version.       
All the versions are following the pattern X.X.X, which is equivalen to major.minor.path
The major, minor, path are increment by 1 depending the user selection

Ex.: current version = 0.0.1
--major => 1.0.0
--minor => 0.1.0
--patch => 0.0.2
''',
    )
    ..addFlag(
      'dry-run',
      defaultsTo: false,
      negatable: false,
      help: 'Nothing will be commited',
    )
    ..addFlag(
      'help',
      defaultsTo: false,
      negatable: false,
      help: 'Show this help',
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

  final argRemote = prettyArgs['remote'] as String?;
  final argVersion = prettyArgs['version'] as String?;
  final isDryRun = prettyArgs['dry-run'] as bool?;
  final isHelp = prettyArgs['help'] as bool;

  if (isHelp) {
    print(argParser.usage);
    return;
  }

  // Get current tag
  final tagResult = await Process.run(
      'git', ['tag', '--list', '--sort=-taggerdate', '--sort=committerdate']);
  if (tagResult.exitCode != 0) {
    print(tagResult.stderr);
    print('');
    print(argParser.usage);
    return;
  }

  const tagPrefix = 'v';
  var version = Version(0, 0, 1);
  final currentVersion = (tagResult.stdout as String)
      .split('\n')
      .lastWhereOrNull((element) => element.startsWith(tagPrefix));
  if (currentVersion != null) {
    final tagWithoutStage = currentVersion
        .substring(currentVersion.lastIndexOf(RegExp('[${tagPrefix}_]')) + 1);
    version = Version.parse(tagWithoutStage);
  }

  Version newVersion;
  if (argVersion == 'major') {
    newVersion = Version(
      version.nextMajor.major,
      version.nextMajor.minor,
      version.nextMajor.patch,
    );
  } else if (argVersion == 'minor') {
    newVersion = Version(
      version.nextMinor.major,
      version.nextMinor.minor,
      version.nextMinor.patch,
    );
  } else {
    newVersion = Version(
      version.nextPatch.major,
      version.nextPatch.minor,
      version.nextPatch.patch,
    );
  }
  print('Current tag: $currentVersion');

  final newTag = '$tagPrefix$newVersion';
  if (!isDryRun!) {
    final createResult = await Process.run('git', ['tag', newTag]);
    if (createResult.exitCode != 0) {
      print(createResult.stderr);
      print('');
      print(argParser.usage);
      return;
    }
  }
  print('Tag $newTag created');

  final remote = argRemote?.toLowerCase() ?? 'origin';
  if (!isDryRun) {
    final pushResult = await Process.run('git', ['push', remote, newTag]);
    if (pushResult.exitCode != 0) {
      print(pushResult.stderr);
      print('');
      print(argParser.usage);
      return;
    }
  }
  print('Tag $newTag pushed to $remote');
  print('Done');
  print('New tag will be $newTag');
}
