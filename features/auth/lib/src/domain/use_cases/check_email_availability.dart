import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';

typedef CheckEmailAvailabilityParams = ({String email});

final class CheckEmailAvailability
    extends UseCase<bool, CheckEmailAvailabilityParams> {
  CheckEmailAvailability({
    required this.authRepository,
    required super.logger,
  });

  final AuthRepository authRepository;

  @override
  Future<bool> execute(CheckEmailAvailabilityParams params) =>
      authRepository.checkEmailAvailability(email: params.email);
}
