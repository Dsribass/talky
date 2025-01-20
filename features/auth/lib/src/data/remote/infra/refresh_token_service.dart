import 'package:auth/src/data/models/token_dto.dart';
import 'package:auth/src/data/remote/infra/endpoints.dart';
import 'package:core/dependencies.dart';
import 'package:core/infra.dart';

class RefreshTokenService implements RefreshToken {
  RefreshTokenService({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  @override
  Future<Token> call(String token) async {
    try {
      final response = await _httpClient.post<Map<String, dynamic>>(
        AuthEndpoints.refreshToken.path,
        data: {'refreshToken': token},
      );

      final updatedToken = TokenRemoteDto.fromJson(response.data!);

      return Token(
        accessToken: updatedToken.accessToken,
        refreshToken: updatedToken.refreshToken,
      );
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 401) {
        throw TokenException.fromDioException(error);
      }

      rethrow;
    }
  }
}
