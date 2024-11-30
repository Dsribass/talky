import 'package:core/dependencies.dart';
import 'package:core/exceptions.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenManager {
  TokenManager(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  final _accessTokenKey = 'auth_access_token';
  final _refreshTokenKey = 'auth_refresh_token';

  bool isRefreshingToken = false;

  bool hasTokenExpired(String token) => JwtDecoder.isExpired(token);

  Future<Map<String, dynamic>> getDecodedAccessToken() async {
    final accessToken = await getAccessToken();

    return JwtDecoder.decode(accessToken);
  }

  Future<void> deleteToken() => Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
      ]);

  Future<void> upsertToken({
    required String accessToken,
    required String refreshToken,
  }) =>
      Future.wait([
        _secureStorage.write(key: _accessTokenKey, value: accessToken),
        _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
      ]);

  Future<String> getAccessToken() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);

    if (accessToken == null) {
      throw ItemNotFoundException(message: 'Access token not found');
    }

    return accessToken;
  }

  Future<String> getRefreshToken() async {
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);

    if (refreshToken == null) {
      throw ItemNotFoundException(message: 'Refresh token not found');
    }

    return refreshToken;
  }
}
