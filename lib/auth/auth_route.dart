import 'package:flutter/material.dart';
import 'package:flutter_fastapp/app_scaffold.dart';
import 'package:flutter_fastapp/auth/auth_page.dart';
import 'package:go_router/go_router.dart';

@immutable
class AuthRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppScaffold(
      childBuilder: (context) => AuthPage(),
    );
  }
}
