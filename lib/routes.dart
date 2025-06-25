import 'package:fire_scribe/app_scaffold.dart';
import 'package:fire_scribe/dashboard/dashboard_page.dart';
import 'package:fire_scribe/import_export/import_export_page.dart';
import 'package:fire_scribe/license/pages/mic_oss_license_single_page.dart';
import 'package:fire_scribe/license/pages/third_party_licenses_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<HomeRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(path: '/dashboard'),
    TypedGoRoute<ImportExportRoute>(path: '/import-export'),
    TypedGoRoute<ThirdPartyLicensesRoute>(
      path: '/third-party-licenses',
      routes: [
        TypedGoRoute<ThirdPartyLicensesDetailRoute>(
          path: ':thirdPartyLicensePackageName',
        ),
      ],
    ),
  ],
)
@immutable
class HomeRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return navigator;
  }
}

@immutable
class DashboardRoute extends GoRouteData with _$DashboardRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: AppScaffold(child: DashboardPage()));
  }
}

@immutable
class ImportExportRoute extends GoRouteData with _$ImportExportRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: AppScaffold(child: ImportExportPage()));
  }
}

@immutable
class ThirdPartyLicensesRoute extends GoRouteData
    with _$ThirdPartyLicensesRoute {
  @override
  Page<void> buildPage(final BuildContext context, final GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(child: ThirdPartyLicensesPage()),
    );
  }
}

@immutable
class ThirdPartyLicensesDetailRoute extends GoRouteData
    with _$ThirdPartyLicensesDetailRoute {
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
