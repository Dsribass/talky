import 'package:core/dependencies.dart';
import 'package:core/modular.dart';
import 'package:core/utils.dart';
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
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    _appBloc = AppBloc(
      globalStateNotifier: inject(),
    )..add(const LoadApp());
    super.initState();
  }

  String? handleRedirection(
    AppState appState,
    GoRouterState routerState,
  ) {
    final currentPath = routerState.matchedLocation;

    return switch (appState) {
      AppLoggedOut() => _redirectIfNotInPath(
          currentPath,
          GlobalRoutes.auth.path,
        ),
      AppProfile() => _redirectIfNotInPath(
          currentPath,
          GlobalRoutes.profile.path,
        ),
      AppLoggedIn() => _redirectIfNotInPath(
          currentPath,
          GlobalRoutes.chat.path,
        ),
      AppInitial() => null,
    };
  }

  String? _redirectIfNotInPath(String currentPath, String targetPath) {
    return currentPath.contains(targetPath) ? null : targetPath;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: TalkyThemeData.lightTheme,
      routerConfig: GoRouter(
        navigatorKey: _navigatorKey,
        initialLocation: GlobalRoutes.root.path,
        refreshListenable: _appBloc.stream.toListenable(),
        redirect: (_, routerState) => handleRedirection(
          _appBloc.state,
          routerState,
        ),
        routes: [
          GoRoute(
            name: GlobalRoutes.root.name,
            path: GlobalRoutes.root.path,
            builder: (_, __) => const _SplashPage(),
          ),
          GoRoute(
            name: GlobalRoutes.profile.name,
            path: GlobalRoutes.profile.path,
            builder: (_, __) => const Scaffold(
              body: Center(
                child: Text('Profile'),
              ),
            ),
          ),
          ...widget.modularConfig.routes,
        ],
      ),
      localizationsDelegates: widget.modularConfig.localizationsDelegates,
      supportedLocales: widget.modularConfig.supportedLocales,
    );
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

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
            const Positioned(
              bottom: TKSpacing.x12,
              child: SizedBox(
                width: TKSpacing.x6,
                height: TKSpacing.x6,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
