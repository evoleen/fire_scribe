import 'package:fire_scribe/oss_licenses.dart';
import 'package:flutter/material.dart';

class MiscOssLicenseSingleRouteArguments {
  const MiscOssLicenseSingleRouteArguments(this.package);
  final Package package;
}

class MiscOssLicenseSinglePage extends StatelessWidget {
  const MiscOssLicenseSinglePage({
    super.key,
    required this.packageName,
  });

  final String packageName;

  String _bodyText(final Package package) {
    return package.license?.split('\n').map((line) {
          if (line.startsWith('//')) {
            line = line.substring(2);
          }

          line = line.trim();
          return line;
        }).join('\n') ??
        '';
  }

  @override
  Widget build(final BuildContext context) {
    final package =
        ossLicenses.firstWhere((final element) => element.name == packageName);

    return Container(
      color: Theme.of(context).canvasColor,
      child: ListView(
        children: <Widget>[
          if (package.description.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(
                package.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          if (package.homepage != null)
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(
                package.homepage ?? '',
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          if (package.description.isNotEmpty || package.homepage != null)
            const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: Text(
              _bodyText(package),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
