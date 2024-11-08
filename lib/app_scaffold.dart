import 'package:fire_scribe/app_drawer_menu.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: SelectionArea(
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                children: [
                  AppDrawerMenu(),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
