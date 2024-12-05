import 'package:auth/src/data/models/user_dto.dart';

abstract interface class UserLocalDataSource {
  Future<void> saveUser(UserLocalDTO user);
  Future<void> saveUserEmail(String email);
  Future<void> saveUserName(String name);
  Future<UserLocalDTO> getUser();
  Future<void> clear();
}
