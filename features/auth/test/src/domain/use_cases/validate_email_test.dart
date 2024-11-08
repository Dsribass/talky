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
    test('should return TKEmptyInputException when password is empty',
        () async {
      // Arrange
      const params = (password: '');

      // Act
      final result = await validatePassword(params);

      // Assert
      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<EmptyInputException>());
      final logs = fakeLogger.getErrorLogs();
      expect(logs.length, equals(1));
      expect(logs.first, isA<EmptyInputException>());
    });

    test(
        'should return TKInvalidInputException when password is less than 6 characters',
        () async {
      // Arrange
      const params = (password: 'abc12');

      // Act
      final result = await validatePassword(params);

      // Assert
      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<InvalidInputException>());
      final logs = fakeLogger.getErrorLogs();
      expect(logs.length, equals(1));
      expect(logs.first, isA<InvalidInputException>());
    });

    test('should return TKInvalidInputException when password has no digits',
        () async {
      // Arrange
      const params = (password: 'abcdefg');

      // Act
      final result = await validatePassword(params);

      // Assert
      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<InvalidInputException>());
      final logs = fakeLogger.getErrorLogs();
      expect(logs.length, equals(1));
      expect(logs.first, isA<InvalidInputException>());
    });

    test('should return TKInvalidInputException when password has no letters',
        () async {
      // Arrange
      const params = (password: '123456');

      // Act
      final result = await validatePassword(params);

      // Assert
      expect(result.isError(), isTrue);
      expect(result.exceptionOrNull(), isA<InvalidInputException>());
      final logs = fakeLogger.getErrorLogs();
      expect(logs.length, equals(1));
      expect(logs.first, isA<InvalidInputException>());
    });

    test('should return success when password is valid', () async {
      // Arrange
      const params = (password: 'abc123');

      // Act
      final result = await validatePassword(params);

      // Assert
      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull(), equals(unit));
    });
  });
}
