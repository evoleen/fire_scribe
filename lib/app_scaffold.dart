import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget Function(BuildContext) childBuilder;

  const AppScaffold({
    super.key,
    required this.childBuilder,
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
              child: childBuilder(context),
            ),
          ),
        ),
      ),
    );
  }
}
