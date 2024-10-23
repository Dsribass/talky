import 'package:core/src/infra/network/http_client/http_client.dart';
import 'package:core/src/infra/network/http_client/http_error_mapper.dart';
import 'package:dio/dio.dart';

class DefaultHttpClient extends HttpClient {
  DefaultHttpClient({required super.options});

  @override
  Exception errorMapper(DioException error, StackTrace stackTrace) {
    return HttpErrorMapper.tryMapDioError(error, stackTrace);
  }
}
