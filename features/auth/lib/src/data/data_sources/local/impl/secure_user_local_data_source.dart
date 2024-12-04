import 'package:auth/src/data/data_sources/local/user_local_data_source.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:core/dependencies.dart';
import 'package:core/exceptions.dart';

class SecureUserLocalDataSource implements UserLocalDataSource {
  SecureUserLocalDataSource(this._secureStorage);

  final FlutterSecureStorage _secureStorage;
  static const _userEmailKey = 'user_email';
  static const _userNameKey = 'user_name';

  @override
  Future<void> clear() => _secureStorage.deleteAll();

  @override
  Future<UserLocalDTO> getUser() async {
    final email = await _secureStorage.read(key: _userEmailKey);
    final name = await _secureStorage.read(key: _userNameKey);

    if (email == null) {
      throw ItemNotFoundException(message: 'User not found');
    }

    return UserLocalDTO(email: email, name: name);
  }

  @override
  Future<void> saveUser(UserLocalDTO user) => Future.wait([
        _secureStorage.write(key: _userEmailKey, value: user.email),
        _secureStorage.write(key: _userNameKey, value: user.name),
      ]);

  @override
  Future<void> saveUserEmail(String email) =>
      _secureStorage.write(key: _userEmailKey, value: email);

  @override
  Future<void> saveUserName(String name) =>
      _secureStorage.write(key: _userNameKey, value: name);
}
