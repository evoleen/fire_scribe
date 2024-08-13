import 'dart:async';

import 'package:flutter/foundation.dart';

class ListenableStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  ListenableStream(final Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
