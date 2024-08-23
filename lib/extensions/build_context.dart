import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  /// This function removes the current Snackbar from screen and displays new one
  void popAndPushSnackbar({
    required final String message,
    final Duration duration = const Duration(milliseconds: 3000),
  }) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar(reason: SnackBarClosedReason.swipe)
      ..showSnackBar(
        SnackBar(
          duration: duration,
          content: Text(
            message,
          ),
        ),
      );
  }
}
