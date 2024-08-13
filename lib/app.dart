import 'dart:async';

import 'package:auth_cubit/auth_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fastapp/app_scaffold.dart';
import 'package:flutter_fastapp/app_theme.dart';
import 'package:flutter_fastapp/auth/auth_route.dart';
import 'package:flutter_fastapp/clients/clients_route.dart';
import 'package:flutter_fastapp/l10n/generated/l10n.dart';
import 'package:flutter_fastapp/listenable_stream.dart';
import 'package:flutter_fastapp/routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  static FutureOr<String?> authGuardRedirect(
    final BuildContext context,
    final GoRouterState state,
  ) async {
    final redirectTo = GetIt.instance.get<AuthCubit>().state.whenOrNull(
      authenticated: (_) {
        if (state.uri.toString().startsWith(AuthRoute().location)) {
          return decodeUrlRedirect(state.uri.toString()) ??
              ClientsRoute().location;
        }
      },
      unauthenticated: () {
        if (!state.uri.toString().startsWith(AuthRoute().location)) {
          return encodeUrlRedirect(
            AuthRoute().location,
            state.uri.toString(),
          );
        }
      },
    );

    return redirectTo;
  }

  static String encodeUrlRedirect(
    final String route,
    final String routeToRedirect,
  ) {
    if (routeToRedirect.isEmpty) {
      return route;
    }
    final uri = Uri.encodeFull(routeToRedirect);
    if (route.contains('redirect=')) {
      return '$route&redirect=$uri';
    } else {
      return '$route?redirect=$uri';
    }
  }

  static String? decodeUrlRedirect(final String routeToRedirect) {
    if (routeToRedirect.contains('redirect=')) {
      final uri = Uri.dataFromString(Uri.decodeFull(routeToRedirect));
      final redirectUri = uri.queryParametersAll['redirect']?.last ?? '';
      return redirectUri.isEmpty ? null : redirectUri;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: ClientsRoute().location,
      debugLogDiagnostics: kDebugMode,
      navigatorKey: GetIt.instance<GlobalKey<NavigatorState>>(),
      redirect: authGuardRedirect,
      routes: $appRoutes,
      refreshListenable: ListenableStream(
        BlocProvider.of<AuthCubit>(context).stream,
      ),
      errorBuilder: (context, state) {
        return AppScaffold(
          childBuilder: (context) => _AppErrorPage(),
        );
      },
    );

    return MaterialApp.router(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

class _AppErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 100,
          ),
          SizedBox(height: 20),
          Text(
            S.current.appErrorPageMessage,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).refresh(),
            child: Text(S.current.refresh),
          ),
        ],
      ),
    );
  }
}
