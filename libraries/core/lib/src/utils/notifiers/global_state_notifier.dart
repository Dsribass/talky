import 'package:core/modular.dart';
import 'package:flutter/widgets.dart';

class GlobalStateNotifier extends ChangeNotifier {
  GlobalStateNotifier();

  static GlobalStateNotifier get I => inject();

  GlobalState _state = GlobalState.loggedOut;

  GlobalState get state => _state;

  void changeState(GlobalState state) {
    _state = state;
    notifyListeners();
  }
}

enum GlobalState {
  loggedOut,
  waitingForSetupProfile,
  loggedIn,
}
