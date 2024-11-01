import 'package:core/core.dart';
import 'package:core/src/infra/network/http_client/http_error_mapper.dart';
import 'package:core/src/infra/network/http_client/models/chat_error_response.dart';

class ChatHttpClient extends HttpClient {
  ChatHttpClient({required super.options});

  @override
  Exception errorMapper(DioException error, StackTrace stackTrace) {
    final response = error.response;

    if (response == null) {
      return HttpErrorMapper.tryMapDioError(error, stackTrace);
    }

    final data = response.data as Map<String, dynamic>;
    final mappedResponse = ChatErrorResponse.fromJson(data);
    final networkErrorType = HttpErrorMapper.getNetworkErrorType(error);

    return TKNetworkException(
      statusError: networkErrorType,
      originalError: error,
      originalStackTrace: stackTrace,
      statusCode: response.statusCode ?? 0,
      inputIssues: mappedResponse.inputIssues,
      message: '${mappedResponse.message} (${mappedResponse.error})',
    );
  }
}
