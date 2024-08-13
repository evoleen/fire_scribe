import 'package:flutter/material.dart';
import 'package:flutter_fastapp/l10n/generated/l10n.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(S.current.clients),
        Expanded(
          child: Placeholder(),
        ),
      ],
    );
  }
}
