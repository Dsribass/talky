import 'package:auth/src/data/data_sources/local/token_local_data_source.dart';
import 'package:auth/src/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:core/dependencies.dart';

final class DefaultAuthRepository implements AuthRepository {
  const DefaultAuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
    required TokenLocalDataSource tokenLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _tokenLocalDataSource = tokenLocalDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;
  final TokenLocalDataSource _tokenLocalDataSource;

  @override
  Future<Unit> signIn({required String email, required String password}) async {
    final userDTO = UserRemoteDTO(email: email, password: password);

    final token = await _authRemoteDataSource.signIn(userDTO);

    await _tokenLocalDataSource.saveToken(
      token: token.toCache(),
    );

    return unit;
  }
}
