import 'package:core/src/infra/network/interceptor/token/token.dart';

abstract interface class TokenManager {
  Future<void> upsertToken(Token token);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  bool hasTokenExpired(String token);

  Future<void> deleteToken();
}
