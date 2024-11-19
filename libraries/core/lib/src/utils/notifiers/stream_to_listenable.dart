import 'dart:async';

import 'package:flutter/widgets.dart';

class StreamToListenable extends ChangeNotifier {
  StreamToListenable(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<void> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

extension StreamToListenableX on Stream<dynamic> {
  ChangeNotifier toListenable() => StreamToListenable(this);
}
