import 'package:firearrow_admin_app/dashboard/dashboard_route.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:firearrow_admin_app/routes.dart';
import 'package:firearrow_admin_app/settings/settings_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AppDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 80,
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            InkWell(
              onTap: () => DashboardRoute().location,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 64,
                  height: 64,
                ),
              ),
            ),
            SizedBox(height: 32),
            ...[
              AppDrawerMenuItemData(
                icon: Symbols.dns,
                title: S.of(context).server,
                route: DashboardRoute().location,
              ),
              AppDrawerMenuItemData(
                icon: Symbols.settings,
                title: S.of(context).settings,
                route: SettingsRoute().location,
              ),
              AppDrawerMenuItemData(
                icon: Symbols.admin_panel_settings,
                title: S.of(context).privacyPolicy,
                route: PrivacyPolicyRoute().location,
              ),
              AppDrawerMenuItemData(
                icon: Symbols.description,
                title: S.of(context).termsOfUse,
                route: TermsOfUseRoute().location,
              ),
              AppDrawerMenuItemData(
                icon: Symbols.license,
                title: S.of(context).thirdPartyLicenses,
                route: ThirdPartyLicensesRoute().location,
              ),
            ].map(
              (item) => AppDrawerMenuItem(
                data: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerMenuItem extends StatelessWidget {
  final AppDrawerMenuItemData data;

  const AppDrawerMenuItem({
    super.key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    final isSelected = location.toString().startsWith(data.route);

    return InkWell(
      onTap: () => GoRouter.of(context).go(data.route),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: isSelected
                    ? BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(24),
                      )
                    : null,
                child: Icon(
                  data.icon,
                  fill: 1,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 4),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerMenuItemData {
  final IconData icon;
  final String title;
  final String route;

  AppDrawerMenuItemData({
    required this.icon,
    required this.title,
    required this.route,
  });
}
