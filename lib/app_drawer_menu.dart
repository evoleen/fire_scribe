import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AppDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                width: 64,
                height: 64,
              ),
            ),
            SizedBox(height: 32),
            ...[
              AppDrawerMenuItemData(
                icon: Symbols.dns,
                title: 'Server',
              ),
              AppDrawerMenuItemData(
                icon: Symbols.settings,
                title: 'Settings',
              ),
              AppDrawerMenuItemData(
                icon: Symbols.admin_panel_settings,
                title: 'Privacy Policy',
              ),
              AppDrawerMenuItemData(
                icon: Symbols.description,
                title: 'Terms Of Use',
              ),
              AppDrawerMenuItemData(
                icon: Symbols.license,
                title: 'Third-Party Licenses',
              ),
            ].map(
              (item) => AppDrawerMenuItem(
                data: item,
                onTap: () {},
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
  final Function() onTap;

  const AppDrawerMenuItem({
    super.key,
    required this.data,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
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
              child: Icon(
                data.icon,
                fill: 1,
                size: 24,
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

  AppDrawerMenuItemData({
    required this.icon,
    required this.title,
  });
}
