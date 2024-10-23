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

final class TKItemNotFoundException extends TKException {
  TKItemNotFoundException({required super.message});
}

final class TKNetworkException extends TKException {
  TKNetworkException({
    required super.message,
    required this.type,
    required this.statusCode,
    this.inputIssues = const {},
    super.originalError,
    super.originalStackTrace,
  });

  final int statusCode;
  final NetworkErrorType type;
  final Map<String, List<String>> inputIssues;

  String get detailedMessage {
    final message = StringBuffer()
      ..write('NetworkException')
      ..write('[${type.name}]')
      ..write(': ')
      ..write(this.message)
      ..write('\n\n')
      ..write('Original error: ')
      ..write(originalError);

    if (inputIssues.isNotEmpty) {
      message
        ..write('\n')
        ..write('Input issues: ')
        ..write(inputIssues.toString());
    }

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
