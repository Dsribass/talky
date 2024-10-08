abstract interface class Logger {
  void call(
    String message, {
    required Object error,
    required StackTrace stackTrace,
  });
}
