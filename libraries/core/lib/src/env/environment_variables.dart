import 'package:core/src/env/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

extension EnvironmentVariables on Environment {
  String get chatApiBaseUrl => dotenv.get('CHAT_API_BASE_URL');
}
