import 'package:auth/src/data/local/user_local_data_source.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:auth/src/data/remote/auth_remote_data_source.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:core/dependencies.dart';

final class DefaultAuthRepository implements AuthRepository {
  const DefaultAuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
    required UserLocalDataSource userLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _userLocalDataSource = userLocalDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  @override
  Future<Unit> signIn({required String email, required String password}) async {
    final userDTO = UserRemoteDTO(email: email, password: password);

    await _authRemoteDataSource.signIn(userDTO);
    await _userLocalDataSource.saveUser(
      userDTO.toLocal(),
    );

    return unit;
  }

  @override
  Future<Unit> signUp({required String email, required String password}) async {
    final userDTO = UserRemoteDTO(email: email, password: password);

    await _authRemoteDataSource.signUp(userDTO);
    await _userLocalDataSource.saveUser(
      userDTO.toLocal(),
    );

    return unit;
  }

  @override
  Future<bool> checkEmailAvailability({required String email}) {
    final userDTO = UserRemoteDTO(email: email, password: null);

    return _authRemoteDataSource.checkEmailAvailability(userDTO);
  }
}
