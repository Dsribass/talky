import 'package:auth/src/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:result_dart/src/unit.dart';

final class DefaultAuthRepository implements AuthRepository {
  const DefaultAuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<Unit> signIn({required String email, required String password}) async {
    final userDTO = UserRemoteDTO(email: email, password: password);

    await _authRemoteDataSource.signIn(userDTO);
    // Save Token

    return unit;
  }
}
