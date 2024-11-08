import 'package:fire_scribe/app_scaffold.dart';
import 'package:fire_scribe/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
class DashboardRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      child: AppScaffold(
        childBuilder: (context) => DashboardPage(),
      ),
    );
  }
}
