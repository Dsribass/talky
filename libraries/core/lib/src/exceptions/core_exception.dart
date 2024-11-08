abstract class CoreException implements Exception {
  CoreException({
    required this.message,
    this.originalError,
    this.originalStackTrace,
  });

  final String message;
  final Object? originalError;
  final StackTrace? originalStackTrace;

  @override
  String toString() => message;
}
