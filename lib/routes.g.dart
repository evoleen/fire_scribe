// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => ShellRouteData.$route(
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/dashboard',
          factory: _$DashboardRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/import-export',
          factory: _$ImportExportRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/third-party-licenses',
          factory: _$ThirdPartyLicensesRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':thirdPartyLicensePackageName',
              factory: _$ThirdPartyLicensesDetailRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();
}

mixin _$DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) => DashboardRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashboard',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ImportExportRoute on GoRouteData {
  static ImportExportRoute _fromState(GoRouterState state) =>
      ImportExportRoute();

  @override
  String get location => GoRouteData.$location(
        '/import-export',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ThirdPartyLicensesRoute on GoRouteData {
  static ThirdPartyLicensesRoute _fromState(GoRouterState state) =>
      ThirdPartyLicensesRoute();

  @override
  String get location => GoRouteData.$location(
        '/third-party-licenses',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ThirdPartyLicensesDetailRoute on GoRouteData {
  static ThirdPartyLicensesDetailRoute _fromState(GoRouterState state) =>
      ThirdPartyLicensesDetailRoute(
        thirdPartyLicensePackageName:
            state.pathParameters['thirdPartyLicensePackageName']!,
      );

  ThirdPartyLicensesDetailRoute get _self =>
      this as ThirdPartyLicensesDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/third-party-licenses/${Uri.encodeComponent(_self.thirdPartyLicensePackageName)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
