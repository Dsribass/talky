import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';

enum FlavorEnv {
  dev,
  prod,
}

class Environment {
  Environment._();

  static Future<Environment> init(FlavorEnv flavor) async {
    final file = switch (flavor) {
      FlavorEnv.dev => '.env.dev',
      FlavorEnv.prod => '.env',
    };

    await dotenv.load(fileName: 'packages/core/$file');

    return Environment._();
  }
}
