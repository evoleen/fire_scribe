import 'package:fire_scribe/dashboard/dashboard_route.dart';
import 'package:fire_scribe/license/license_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<HomeRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(
      path: '/dashboard',
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
