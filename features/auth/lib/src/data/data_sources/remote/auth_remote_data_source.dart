import 'package:auth/src/data/models/token_dto.dart';
import 'package:auth/src/data/models/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<TokenRemoteDto> signIn(UserRemoteDTO user);
}
