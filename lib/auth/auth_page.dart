import 'package:auth_cubit_firebase/auth_cubit_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fastapp/l10n/generated/l10n.dart';

class AuthPage extends StatelessWidget {
  const AuthPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 20,
      ),
      child: Column(
        children: [
          Text(S.current.loginEmailPassword),
          const SizedBox(height: 32),
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FirebaseEmailPasswordAuthForm()),
        ],
      ),
    );
  }
}
