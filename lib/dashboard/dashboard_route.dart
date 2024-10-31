import 'package:fire_scribe/app_scaffold.dart';
import 'package:fire_scribe/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
class DashboardRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppScaffold(
      childBuilder: (context) => DashboardPage(),
    );
  }
}
