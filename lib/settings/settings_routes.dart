import 'package:firearrow_admin_app/app_scaffold.dart';
import 'package:firearrow_admin_app/settings/pages/mic_oss_license_single_page.dart';
import 'package:firearrow_admin_app/settings/pages/privacy_policy_page.dart';
import 'package:firearrow_admin_app/settings/pages/settings_page.dart';
import 'package:firearrow_admin_app/settings/pages/terms_of_use_page.dart';
import 'package:firearrow_admin_app/settings/pages/third_party_licenses_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
class SettingsRoute extends GoRouteData {
  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        childBuilder: (context) => SettingsPage(),
      ),
    );
  }
}

@immutable
class PrivacyPolicyRoute extends GoRouteData {
  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        childBuilder: (context) => PrivacyPolicyPage(),
      ),
    );
  }
}

@immutable
class TermsOfUseRoute extends GoRouteData {
  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        childBuilder: (context) => TermsOfUsePage(),
      ),
    );
  }
}

@immutable
class ThirdPartyLicensesRoute extends GoRouteData {
  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        childBuilder: (context) => ThirdPartyLicensesPage(),
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
        childBuilder: (context) => MiscOssLicenseSinglePage(
          packageName: thirdPartyLicensePackageName,
        ),
      ),
    );
  }
}
