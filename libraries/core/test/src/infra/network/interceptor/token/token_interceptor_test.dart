import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RefreshTokenMock extends Mock implements RefreshToken {}

class TokenManagerMock extends Mock implements TokenManager {}

class QueueRetryRequestMock extends Mock implements RetryRequestQueue {}

class RequestInterceptorHandlerMock extends Mock
    implements RequestInterceptorHandler {}

class ErrorInterceptorHandlerMock extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  late RefreshToken refreshToken;
  late TokenManager tokenManager;
  late RetryRequestQueue queuedRequests;

  late TokenInterceptor tokenInterceptor;

  const fakePath = '/test';
  const fakeAccessToken = 'fakeAccessToken';
  const fakeRefreshToken = 'fakeRefreshToken';

  setUpAll(() {
    registerFallbackValue(
      DioException(requestOptions: RequestOptions(path: fakePath)),
    );
    registerFallbackValue(
      (
        options: RequestOptions(path: fakePath),
        resolve: (_) {},
        reject: (_) {},
      ),
    );
    registerFallbackValue(
      Response<dynamic>(
        requestOptions: RequestOptions(path: fakePath),
        statusCode: 200,
        data: <Map<dynamic, dynamic>>{},
      ),
    );
    refreshToken = RefreshTokenMock();
    tokenManager = TokenManagerMock();
    queuedRequests = QueueRetryRequestMock();

    tokenInterceptor = TokenInterceptor(
      refreshToken: refreshToken,
      tokenManager: tokenManager,
      queuedRequests: queuedRequests,
    );
  });

  group('TokenInterceptor - onRequest', () {
    final options = RequestOptions(path: fakePath);
    final handler = RequestInterceptorHandlerMock();
    test('should reject request when access token is not found', () async {
      when(() => tokenManager.getAccessToken()).thenAnswer((_) async => null);

      await tokenInterceptor.onRequest(options, handler);

      verify(
        () => handler.reject(any()),
      ).called(1);
      verifyNever(() => handler.resolve(any()));
    });

    test(
        'should add Authorization header and call handler.next for valid token',
        () async {
      when(() => tokenManager.getAccessToken())
          .thenAnswer((_) async => fakeAccessToken);
      when(() => tokenManager.hasTokenExpired(fakeAccessToken))
          .thenReturn(false);

      await tokenInterceptor.onRequest(options, handler);

      expect(options.headers['Authorization'], 'Bearer $fakeAccessToken');
      verify(() => handler.next(options)).called(1);
      verifyNever(() => handler.reject(any()));
    });

    test('should call handleInvalidToken if token has expired', () async {
      when(() => tokenManager.getAccessToken())
          .thenAnswer((_) async => fakeAccessToken);
      when(() => tokenManager.hasTokenExpired(any())).thenReturn(true);
      when(() => queuedRequests.add(any())).thenReturn(null);

      await tokenInterceptor.onRequest(options, handler);

      verify(() => tokenManager.getAccessToken()).called(1);
      verify(() => tokenManager.hasTokenExpired(fakeAccessToken)).called(1);
      verify(() => queuedRequests.add(any())).called(1);
    });
  });

  group('TokenInterceptor - onError', () {
    final handler = ErrorInterceptorHandlerMock();

    test('should call handleInvalidToken if response status code is 401',
        () async {
      when(() => queuedRequests.add(any())).thenReturn(null);

      final unauthorizedError = DioException(
        requestOptions: RequestOptions(path: fakePath),
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: fakePath),
          statusCode: 401,
          data: <Map<dynamic, dynamic>>{},
        ),
      );
      await tokenInterceptor.onError(unauthorizedError, handler);

      verify(() => queuedRequests.add(any())).called(1);
    });

    test('should call super.onError if response status code is not 401',
        () async {
      final err = DioException(
        requestOptions: RequestOptions(path: fakePath),
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: fakePath),
          statusCode: 400,
          data: <Map<dynamic, dynamic>>{},
        ),
      );
      await tokenInterceptor.onError(err, handler);

      verifyNever(() => queuedRequests.add(any()));
      verify(() => handler.next(err)).called(1);
    });
  });

  group('TokenInterceptor - handleInvalidToken', () {
    final handler = ErrorInterceptorHandlerMock();
    final retryRequest = (
      options: RequestOptions(path: '/test'),
      resolve: handler.resolve,
      reject: handler.reject,
    );
    const token = Token(
      accessToken: fakeAccessToken,
      refreshToken: fakeRefreshToken,
    );

    test('should add request to queue and process when token refresh succeeds',
        () async {
      // Arrange
      when(() => queuedRequests.add(any())).thenReturn(null);
      when(() => tokenManager.getRefreshToken())
          .thenAnswer((_) async => fakeRefreshToken);
      when(() => tokenManager.hasTokenExpired(fakeRefreshToken))
          .thenReturn(false);
      when(() => refreshToken.call(fakeRefreshToken)).thenAnswer(
        (_) async => token,
      );
      when(() => tokenManager.upsertToken(token)).thenAnswer((_) async {});
      when(() => queuedRequests.resolveQueue(fakeAccessToken))
          .thenAnswer((_) async {});

      // Act
      await tokenInterceptor.handleInvalidToken(retryRequest);

      // Assert
      verify(() => queuedRequests.add(retryRequest)).called(1);
      verify(() => tokenManager.getRefreshToken()).called(1);
      verify(() => tokenManager.hasTokenExpired(fakeRefreshToken)).called(1);
      verify(() => refreshToken.call(fakeRefreshToken)).called(1);
      verify(() => tokenManager.upsertToken(token)).called(1);
      verify(() => queuedRequests.resolveQueue(fakeAccessToken)).called(1);
    });

    test('should reject the request if refresh token is null', () async {
      // Arrange
      when(() => queuedRequests.add(any())).thenReturn(null);
      when(() => tokenManager.getRefreshToken()).thenAnswer((_) async => null);

      // Act
      await tokenInterceptor.handleInvalidToken(retryRequest);

      // Assert
      verify(() => queuedRequests.add(retryRequest)).called(1);
      verify(() => retryRequest.reject(any())).called(1);
    });

    test('should reject the request if refresh token is expired', () async {
      // Arrange
      when(() => queuedRequests.add(any())).thenReturn(null);
      when(() => tokenManager.getRefreshToken()).thenAnswer((_) async => null);
      when(() => tokenManager.hasTokenExpired(fakeRefreshToken))
          .thenReturn(true);

      // Act
      await tokenInterceptor.handleInvalidToken(retryRequest);

      // Assert
      verify(() => queuedRequests.add(retryRequest)).called(1);
      verify(() => retryRequest.reject(any())).called(1);
    });
    test('should reject all requests if token refresh fails', () async {
      when(() => queuedRequests.add(any())).thenReturn(null);
      when(() => tokenManager.getRefreshToken())
          .thenAnswer((_) async => fakeRefreshToken);
      when(() => tokenManager.hasTokenExpired(fakeRefreshToken))
          .thenReturn(false);
      when(() => refreshToken.call(fakeRefreshToken))
          .thenAnswer((_) async => throw Exception());
      when(() => queuedRequests.rejectQueue(any())).thenAnswer((_) async {});

      await tokenInterceptor.handleInvalidToken(retryRequest);

      verify(() => queuedRequests.add(retryRequest)).called(1);
      verify(() => tokenManager.getRefreshToken()).called(1);
      verify(() => tokenManager.hasTokenExpired(fakeRefreshToken)).called(1);
      verify(() => refreshToken.call(fakeRefreshToken)).called(1);
      verify(() => queuedRequests.rejectQueue(any())).called(1);
    });
  });
}
