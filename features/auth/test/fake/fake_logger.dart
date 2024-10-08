import 'package:core/core.dart';

class FakeLogger implements Logger {
  final List<Object> errorLogs = [];

  @override
  void call(
    String message, {
    required Object error,
    StackTrace? stackTrace,
  }) {
    errorLogs.add(error);
  }

  void clearLogs() {
    errorLogs.clear();
  }

  List<Object> getErrorLogs() {
    return List.unmodifiable(errorLogs);
  }
}
