import 'package:collection/collection.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:fire_scribe/license/license_routes.dart';
import 'package:fire_scribe/oss_licenses.dart';
import 'package:fire_scribe/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ThirdPartyLicensesPage extends StatelessWidget {
  static Future<List<Package>> loadLicenses() async {
    // merging non-dart dependency list using LicenseRegistry.
    final lm = <String, List<String>>{};
    await for (final l in LicenseRegistry.licenses) {
      for (final p in l.packages) {
        final lp = lm.putIfAbsent(p, () => []);
        lp.addAll(l.paragraphs.map((final p) => p.text));
      }
    }

    var licenses = List<Package>.from(allDependencies, growable: true);
    for (final key in lm.keys) {
      if (allDependencies
          .where((final element) => lm.containsKey(element.name))
          .isEmpty) {
        licenses.add(
          Package(
            name: key,
            description: '',
            authors: [],
            version: '',
            license: lm[key]!.join('\n\n'),
            isMarkdown: false,
            isSdk: false,
            dependencies: [],
          ),
        );
      }
    }
    return licenses.sorted((final a, final b) => a.name.compareTo(b.name));
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<List<Package>>(
      future: _licenses,
      builder: (final context, final snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          itemCount: (snapshot.data?.length ?? 0) + 1,
          itemBuilder: (final context, final index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).appTitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    SizedBox(height: 0),
                    FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          final data = snapshot.data;
                          if (data == null) {
                            return Text('');
                          }
                          return Text(
                            '${data.version}+${data.buildNumber}',
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 0),
                    Text(
                      S.of(context).license,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              final package = snapshot.data![index - 1];
              return ListTile(
                title: Text(
                  '${package.name} ${package.version}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                subtitle: package.description.isNotEmpty
                    ? Text(package.description,
                        style: Theme.of(context).textTheme.bodyMedium)
                    : null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  ThirdPartyLicensesDetailRoute(
                          thirdPartyLicensePackageName: package.name)
                      .push(context);
                },
              );
            }
          },
          separatorBuilder: (final context, final index) => const Divider(),
        );
      },
    );
  }
}
