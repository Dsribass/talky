abstract class TKException implements Exception {
  TKException({
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

final class TKGenericException extends TKException {
  TKGenericException({
    required super.message,
    super.originalError,
    super.originalStackTrace,
  });
}

sealed class TKInputValidationException extends TKException {
  TKInputValidationException({required super.message});
}

final class TKInvalidInputException extends TKInputValidationException {
  TKInvalidInputException({required super.message});
}

final class TKEmptyInputException extends TKInputValidationException {
  TKEmptyInputException({required super.message});
}

final class TKNetworkException extends TKException {
  TKNetworkException({
    required super.message,
    required this.type,
    super.originalError,
    super.originalStackTrace,
  });

  final NetworkErrorType type;

  @override
  String toString() {
    final message = StringBuffer()
      ..write('NetworkException')
      ..write('[${type.name}]')
      ..write(': ')
      ..write(this.message)
      ..write('\n')
      ..write('Original error: ')
      ..write(originalError);

    return message.toString();
  }
}

enum NetworkErrorType {
  unknown,
  timeout,
  noConnection,
  badRequest,
  internalServerError,
  unauthorized,
  notFound,
  forbidden;
}
