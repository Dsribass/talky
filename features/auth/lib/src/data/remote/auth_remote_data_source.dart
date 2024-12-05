import 'package:auth/src/data/models/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signIn(UserRemoteDTO user);
  Future<void> signUp(UserRemoteDTO user);
}
