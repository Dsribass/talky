import 'package:core/src/exceptions/common_exceptions.dart';
import 'package:core/src/infra/network/http_client/clients/base_api/api_error_response.dart';
import 'package:core/src/infra/network/http_client/clients/base_api/api_http_client_exception.dart';
import 'package:core/src/infra/network/http_client/http_client.dart';
import 'package:core/src/infra/network/http_client/http_error_mapper.dart';
import 'package:core/src/infra/network/interceptor/token/token_exception.dart';
import 'package:dio/dio.dart';

class BaseApiHttpClient extends HttpClient {
  BaseApiHttpClient({required super.options});

  @override
  Exception errorMapper(DioException error, StackTrace stackTrace) {
    final response = error.response;

    if (error is TokenException) {
      throw UserUnauthorizedException(
        message:
            error.message ?? 'Error while trying to get protected resource',
      );
    }

    if (response == null) {
      return HttpErrorMapper.tryMapDioError(error, stackTrace);
    }

    final data = response.data as Map<String, dynamic>;
    final mappedResponse = ApiErrorResponse.fromJson(data);
    final networkErrorType = HttpErrorMapper.getNetworkErrorType(error);

    return ApiHttpClientException(
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
