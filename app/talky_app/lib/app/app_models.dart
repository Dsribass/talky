import 'package:core/dependencies.dart';

// States
sealed class AppState {
  const AppState();
}

@immutable
final class AppInitial extends AppState {
  const AppInitial();
}

@immutable
final class AppLoggedOut extends AppState {
  const AppLoggedOut();
}

@immutable
final class AppProfile extends AppState {
  const AppProfile();
}

@immutable
final class AppLoggedIn extends AppState {
  const AppLoggedIn();
}

// Events
sealed class AppEvent {
  const AppEvent();
}

@immutable
final class LoadApp extends AppEvent {
  const LoadApp();
}

@immutable
final class ChangeAppState extends AppEvent {
  const ChangeAppState(this.state);

  final AppState state;
}
