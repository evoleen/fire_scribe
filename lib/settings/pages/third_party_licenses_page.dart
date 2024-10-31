import 'package:firearrow_admin_app/oss_licenses.dart';
import 'package:firearrow_admin_app/routes.dart';
import 'package:firearrow_admin_app/settings/settings_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

    final licenses = ossLicenses.toList();
    for (final key in lm.keys) {
      if (ossLicenses
          .where((final element) => lm.containsKey(element.name))
          .isEmpty) {
        licenses.add(Package(
          name: key,
          description: '',
          authors: [],
          version: '',
          license: lm[key]!.join('\n\n'),
          isMarkdown: false,
          isSdk: false,
          isDirectDependency: false,
        ));
      }
    }
    return licenses..sort((final a, final b) => a.name.compareTo(b.name));
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
        return Scrollbar(
          child: ListView.separated(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (final context, final index) {
              final package = snapshot.data![index];

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
            },
            separatorBuilder: (final context, final index) => const Divider(),
          ),
        );
      },
    );
  }
}
