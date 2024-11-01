import 'package:firearrow_admin_app/dashboard/dashboard_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<HomeRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(
      path: '/dashboard',
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
