import 'package:firearrow_admin_app/app_scaffold.dart';
import 'package:firearrow_admin_app/app_theme.dart';
import 'package:firearrow_admin_app/dashboard/dashboard_route.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:firearrow_admin_app/l10n/cubit/localization_cubit.dart';
import 'package:firearrow_admin_app/l10n/supported_locales.dart';
import 'package:firearrow_admin_app/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: DashboardRoute().location,
      debugLogDiagnostics: kDebugMode,
      navigatorKey: GetIt.instance<GlobalKey<NavigatorState>>(),
      routes: $appRoutes,
      errorBuilder: (context, state) {
        return AppScaffold(
          child: _AppErrorPage(),
        );
      },
    );

    return BlocProvider(
      create: (final context) => LocalizationCubit(
        sharedPreferences: GetIt.instance(),
      ),
      child: BlocBuilder<LocalizationCubit, LocalizationCubitState>(
        buildWhen: (final _, final current) => current.when(
          initial: () => false,
          locale: (final _) => true,
        ),
        builder: (final context, final state) {
          return state.when(
            initial: () => const SizedBox(),
            locale: (final locale) => MaterialApp.router(
              title: S.of(context).appTitle,
              theme: appTheme,
              debugShowCheckedModeBanner: false,
              supportedLocales: supportedLocales,
              locale: locale,
              localizationsDelegates: S.delegates,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
            ),
          );
        },
      ),
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
            color: Theme.of(context).colorScheme.error,
            size: 100,
          ),
          SizedBox(height: 20),
          Text(
            S.of(context).appErrorPageMessage,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).refresh(),
            child: Text(
              S.of(context).refresh,
            ),
          ),
        ],
      ),
    );
  }
}
