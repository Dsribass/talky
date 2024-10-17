import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';

enum FlavorEnv {
  dev,
  prod,
}

/// Global environment instance
///
/// Ensure the environment configuration is loaded before accessing
/// any environment variables.
/// This can be achieved by calling the [Environment.init] method in the
/// main function.
const env = Environment._();

class Environment {
  const Environment._();

  /// Initializes the environment configuration
  ///
  /// This method loads the appropriate environment configuration file
  /// based on the [FlavorEnv] provided.
  ///
  /// It should be called before the application is run. For example:
  ///
  /// ```dart
  /// void main() async {
  ///   await Environment.init(FlavorEnv.dev);
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<Environment> init(FlavorEnv flavor) async {
    final file = switch (flavor) {
      FlavorEnv.dev => '.env.dev',
      FlavorEnv.prod => '.env',
    };

    await dotenv.load(fileName: 'packages/core/$file');

    return const Environment._();
  }
}
