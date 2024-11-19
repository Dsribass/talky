import 'package:core/src/infra/network/http_client/clients/chat/chat_api_error_response.dart';
import 'package:core/src/infra/network/http_client/clients/chat/chat_http_client_exception.dart';
import 'package:core/src/infra/network/http_client/http_client.dart';
import 'package:core/src/infra/network/http_client/http_error_mapper.dart';
import 'package:dio/dio.dart';

class ChatApiHttpClient extends HttpClient {
  ChatApiHttpClient({required super.options});

  @override
  Exception errorMapper(DioException error, StackTrace stackTrace) {
    final response = error.response;

    if (response == null) {
      return HttpErrorMapper.tryMapDioError(error, stackTrace);
    }

    final data = response.data as Map<String, dynamic>;
    final mappedResponse = ChatApiErrorResponse.fromJson(data);
    final networkErrorType = HttpErrorMapper.getNetworkErrorType(error);

    return ChatHttpClientException(
      statusError: networkErrorType,
      originalError: error,
      originalStackTrace: stackTrace,
      statusCode: response.statusCode ?? 0,
      inputIssues: mappedResponse.inputIssues,
      message: '${mappedResponse.message} (${mappedResponse.error})',
      responseErrorType: mappedResponse.type,
    );
  }
}
