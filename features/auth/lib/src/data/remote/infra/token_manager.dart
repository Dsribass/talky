import 'package:core/dependencies.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenManager {
  TokenManager(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  final _accessTokenKey = 'auth_access_token';
  final _refreshTokenKey = 'auth_refresh_token';

  bool hasTokenExpired(String token) => JwtDecoder.isExpired(token);

  Map<String, dynamic> decodeToken(String token) => JwtDecoder.decode(token);

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

  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);

  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: _refreshTokenKey);
}
