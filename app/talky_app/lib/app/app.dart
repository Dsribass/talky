import 'package:core/dependencies.dart';
import 'package:core/modular.dart';
import 'package:flutter/material.dart';
import 'package:talky_app/app/app_bloc.dart';
import 'package:talky_app/app/app_models.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class App extends StatefulWidget {
  const App({
    required this.modularConfig,
    super.key,
  });

  final ModularAppConfiguration modularConfig;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc _appBloc;

  @override
  void initState() {
    _appBloc = AppBloc(
      globalStateNotifier: inject(),
    )..add(const LoadApp());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      bloc: _appBloc,
      builder: (context, state) => MaterialApp.router(
        theme: TalkyThemeData.lightTheme,
        routerConfig: GoRouter(
          initialLocation: GlobalRoutes.root.path,
          redirect: (_, __) => switch (state) {
            AppLoggedOut() => GlobalRoutes.root.path,
            AppProfile() => GlobalRoutes.profile.path,
            AppLoggedIn() => GlobalRoutes.chat.path,
            _ => null,
          },
          routes: widget.modularConfig.routes,
        ),
        localizationsDelegates: widget.modularConfig.localizationsDelegates,
        supportedLocales: widget.modularConfig.supportedLocales,
        builder: (context, child) {
          final isInitialState = state is AppInitial;

          return isInitialState ? const _AppLogo() : child!;
        },
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surface,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: TalkyAssets.images.splashLogo(),
            ),
            Positioned(
              bottom: TKSpacing.x12,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(context.colors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
