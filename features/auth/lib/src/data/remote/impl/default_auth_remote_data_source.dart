import 'package:auth/src/data/exceptions.dart';
import 'package:auth/src/data/models/token_dto.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:auth/src/data/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/remote/infra/endpoints.dart';
import 'package:auth/src/data/remote/infra/token_manager.dart';
import 'package:core/infra.dart';

final class DefaultAuthRemoteDataSource implements AuthRemoteDataSource {
  DefaultAuthRemoteDataSource({
    required HttpClient client,
    required TokenManager tokenManager,
  })  : _client = client,
        _tokenManager = tokenManager;

  final HttpClient _client;
  final TokenManager _tokenManager;

  @override
  Future<void> signIn(UserRemoteDTO user) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        AuthEndpoints.signIn.path,
        data: user.toJson(),
      );

      final token = TokenRemoteDto.fromJson(response.data!);
      await _tokenManager.upsertToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );
    } on HttpClientException catch (e) {
      throw switch (e.statusError) {
        HttpStatusError.unauthorized ||
        HttpStatusError.notFound =>
          InvalidCredentialsException(message: e.message),
        _ => e,
      };
    }
  }

  @override
  Future<void> signUp(UserRemoteDTO user) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        AuthEndpoints.signUp.path,
        data: user.toJson(),
      );

      final token = TokenRemoteDto.fromJson(response.data!);
      await _tokenManager.upsertToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );
    } on ApiHttpClientException catch (e) {
      throw switch (e.responseErrorType) {
        ResponseErrorType.itemAlreadyExists =>
          ItemAlreadyExistsException(message: e.message),
        _ => e,
      };
    }
  }
}
