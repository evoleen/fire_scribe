import 'package:firearrow_admin_app/app_scaffold.dart';
import 'package:firearrow_admin_app/dashboard/dashboard_page.dart';
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
