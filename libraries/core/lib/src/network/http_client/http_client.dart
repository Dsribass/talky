import 'package:core/src/network/http_client/http_error_mapper.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class HttpClient with DioMixin implements Dio {
  HttpClient({
    required HttpOptions options,
  }) {
    super.options = options;
    httpClientAdapter = IOHttpClientAdapter();
  }

  @override
  Future<Response<T>> request<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await super.request(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e, stackTrace) {
      throw HttpErrorMapper.mapError(e, stackTrace);
    }
  }
}

class HttpOptions extends BaseOptions {
  HttpOptions({
    required super.baseUrl,
    super.connectTimeout = const Duration(seconds: 5),
    super.receiveTimeout = const Duration(seconds: 3),
    super.headers,
    super.contentType = Headers.jsonContentType,
  });
}
