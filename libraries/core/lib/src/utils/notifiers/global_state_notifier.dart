import 'package:flutter/widgets.dart';

class GlobalStateNotifier extends ChangeNotifier {
  GlobalStateNotifier();

  GlobalState _state = GlobalState.loggedOut;

  GlobalState get state => _state;

  void set(GlobalState state) {
    _state = state;
    notifyListeners();
  }
}

enum GlobalState {
  loggedOut,
  waitingForSetupProfile,
  loggedIn,
}
