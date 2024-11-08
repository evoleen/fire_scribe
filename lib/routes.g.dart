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
          factory: $DashboardRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/settings',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/privacy-policy',
          factory: $PrivacyPolicyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/terms-of-use',
          factory: $TermsOfUseRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/third-party-licenses',
          factory: $ThirdPartyLicensesRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':thirdPartyLicensePackageName',
              factory: $ThirdPartyLicensesDetailRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();
}

extension $DashboardRouteExtension on DashboardRoute {
  static DashboardRoute _fromState(GoRouterState state) => DashboardRoute();

  String get location => GoRouteData.$location(
        '/dashboard',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PrivacyPolicyRouteExtension on PrivacyPolicyRoute {
  static PrivacyPolicyRoute _fromState(GoRouterState state) =>
      PrivacyPolicyRoute();

  String get location => GoRouteData.$location(
        '/privacy-policy',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TermsOfUseRouteExtension on TermsOfUseRoute {
  static TermsOfUseRoute _fromState(GoRouterState state) => TermsOfUseRoute();

  String get location => GoRouteData.$location(
        '/terms-of-use',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ThirdPartyLicensesRouteExtension on ThirdPartyLicensesRoute {
  static ThirdPartyLicensesRoute _fromState(GoRouterState state) =>
      ThirdPartyLicensesRoute();

  String get location => GoRouteData.$location(
        '/third-party-licenses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ThirdPartyLicensesDetailRouteExtension
    on ThirdPartyLicensesDetailRoute {
  static ThirdPartyLicensesDetailRoute _fromState(GoRouterState state) =>
      ThirdPartyLicensesDetailRoute(
        thirdPartyLicensePackageName:
            state.pathParameters['thirdPartyLicensePackageName']!,
      );

  String get location => GoRouteData.$location(
        '/third-party-licenses/${Uri.encodeComponent(thirdPartyLicensePackageName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
