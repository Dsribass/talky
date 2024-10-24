import 'package:auth/src/domain/use_cases/validate_password.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fake/fake_logger.dart';

void main() {
  late ValidatePassword validatePassword;
  late FakeLogger fakeLogger;

  setUp(() {
    fakeLogger = FakeLogger();
    validatePassword = ValidatePassword(logger: fakeLogger);
  });

  group('ValidatePassword UseCase', () {
    test('should throw TKEmptyInputException when password is empty', () async {
      // Arrange
      const params = (password: '');

      // Act & Assert
      expect(
        () async => validatePassword.execute(params),
        throwsA(isA<TKEmptyInputException>()),
      );
    });

    test(
        'should throw TKInvalidInputException when password is less than 8 characters',
        () async {
      // Arrange
      const params = (password: 'abc12');

      // Act & Assert
      expect(
        () async => validatePassword.execute(params),
        throwsA(isA<TKInvalidInputLengthException>()),
      );
    });

    test('should throw TKInvalidInputException when password has no digits',
        () async {
      // Arrange
      const params = (password: 'abdcefgh');

      // Act & Assert
      expect(
        () async => validatePassword.execute(params),
        throwsA(isA<TKInvalidInputException>()),
      );
    });

    test('should throw TKInvalidInputException when password has no letters',
        () async {
      // Arrange
      const params = (password: '12345678');

      // Act & Assert
      expect(
        () async => validatePassword.execute(params),
        throwsA(isA<TKInvalidInputException>()),
      );
    });

    test('should allow special characters in password', () async {
      // Arrange
      const params = (password: 'abc123!@#');

      // Act
      final result = await validatePassword.execute(params);

      // Assert
      expect(result, equals(unit));
    });

    test('should return Unit when password is valid', () async {
      // Arrange
      const params = (password: 'abc12399');

      // Act
      final result = await validatePassword.execute(params);

      // Assert
      expect(result, equals(unit));
    });
  });
}
