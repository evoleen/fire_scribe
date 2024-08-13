import 'package:flutter/material.dart';
import 'package:flutter_fastapp/app_scaffold.dart';
import 'package:flutter_fastapp/clients/clients_page.dart';
import 'package:go_router/go_router.dart';

@immutable
class ClientsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppScaffold(
      childBuilder: (context) => ClientsPage(),
    );
  }
}
