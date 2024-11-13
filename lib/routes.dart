import 'package:fire_scribe/dashboard/dashboard_route.dart';
import 'package:fire_scribe/settings/settings_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<HomeRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(
      path: '/dashboard',
    ),
    TypedGoRoute<SettingsRoute>(
      path: '/settings',
    ),
    TypedGoRoute<PrivacyPolicyRoute>(
      path: '/privacy-policy',
    ),
    TypedGoRoute<TermsOfUseRoute>(
      path: '/terms-of-use',
    ),
    TypedGoRoute<ThirdPartyLicensesRoute>(
      path: '/third-party-licenses',
      routes: [
        TypedGoRoute<ThirdPartyLicensesDetailRoute>(
          path: ':thirdPartyLicensePackageName',
        )
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
