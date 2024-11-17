import 'package:core/dependencies.dart';
import 'package:core/utils.dart';
import 'package:talky_app/app/app_models.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.globalStateNotifier,
  }) : super(const AppInitial()) {
    on<LoadApp>(_onLoadApp);
    on<ChangeAppState>(_onChangeAppState);

    globalStateNotifier.addListener(() {
      final state = switch (globalStateNotifier.state) {
        GlobalState.loggedOut => const AppLoggedOut(),
        GlobalState.waitingForSetupProfile => const AppProfile(),
        GlobalState.loggedIn => const AppLoggedIn(),
      };

      add(ChangeAppState(state));
    });
  }

  final GlobalStateNotifier globalStateNotifier;

  Future<void> _onLoadApp(LoadApp event, Emitter<AppState> emit) async {
    emit(const AppInitial());

    await Future<dynamic>.delayed(const Duration(seconds: 2));
    try {
      final hasSignedInUser = await Future.value(false);
      final hasSetUserName = await Future.value(false);

      if (hasSignedInUser) {
        if (hasSetUserName) {
          emit(const AppLoggedIn());
        } else {
          emit(const AppProfile());
        }
      } else {
        emit(const AppLoggedOut());
      }
    } catch (e) {
      emit(const AppLoggedOut());
    }
  }

  void _onChangeAppState(ChangeAppState event, Emitter<AppState> emit) {
    emit(event.state);
  }
}
