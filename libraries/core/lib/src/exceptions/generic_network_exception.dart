import 'package:core/src/exceptions/core_exception.dart';

class GenericNetworkException extends CoreException {
  GenericNetworkException({
    required super.message,
    required this.statusError,
    required this.statusCode,
    this.inputIssues = const {},
    super.originalError,
    super.originalStackTrace,
  });

  final int statusCode;
  final NetworkStatusError statusError;
  final Map<String, List<String>> inputIssues;

  String get detailedMessage {
    final message = StringBuffer()
      ..write('NetworkException')
      ..write('[${statusError.name}]')
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

enum NetworkStatusError {
  unknown,
  timeout,
  noConnection,
  badRequest,
  internalServerError,
  unauthorized,
  notFound,
  forbidden;
}
