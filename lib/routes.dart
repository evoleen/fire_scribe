import 'package:flutter/material.dart';
import 'package:flutter_fastapp/auth/auth_route.dart';
import 'package:flutter_fastapp/clients/clients_route.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<HomeRoute>(
  routes: [
    TypedGoRoute<AuthRoute>(
      path: '/auth',
    ),
    TypedGoRoute<ClientsRoute>(
      path: '/clients',
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
