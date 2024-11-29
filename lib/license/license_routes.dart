import 'package:fire_scribe/app_scaffold.dart';
import 'package:fire_scribe/license/pages/mic_oss_license_single_page.dart';
import 'package:fire_scribe/license/pages/third_party_licenses_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
class ThirdPartyLicensesRoute extends GoRouteData {
  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        child: ThirdPartyLicensesPage(),
      ),
    );
  }
}

@immutable
class ThirdPartyLicensesDetailRoute extends GoRouteData {
  final String thirdPartyLicensePackageName;
  const ThirdPartyLicensesDetailRoute({
    required this.thirdPartyLicensePackageName,
  });

  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        child: MiscOssLicenseSinglePage(
          packageName: thirdPartyLicensePackageName,
        ),
      ),
    );
  }
}
