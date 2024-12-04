import 'package:core/src/infra/network/http_client/clients/base_api/api_error_response.dart';
import 'package:core/src/infra/network/http_client/http_client_exception.dart';

final class ApiHttpClientException extends HttpClientException {
  ApiHttpClientException({
    required super.message,
    required super.statusError,
    required super.statusCode,
    required this.responseErrorType,
    super.originalError,
    super.originalStackTrace,
    this.inputIssues = const {},
  });

  final Map<String, List<String>> inputIssues;
  final ResponseErrorType responseErrorType;

  @override
  String get detailedMessage {
    final message = StringBuffer(super.detailedMessage)
      ..write('\n')
      ..write('Error type: ')
      ..write(responseErrorType.name);

    if (inputIssues.isNotEmpty) {
      message
        ..write('\n')
        ..write('Input issues: ')
        ..write(inputIssues.toString());
    }

    return message.toString();
  }
}
