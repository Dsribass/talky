import 'package:core/src/exceptions/exceptions.dart';
import 'package:core/src/utils/logger.dart';
import 'package:meta/meta.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

abstract base class UseCase<T extends Object, P> {
  const UseCase({required this.logger});

  @protected
  final Logger logger;

  @protected
  Future<T> execute(P params);

  AsyncResult<T, CoreException> call(P params) async {
    try {
      return successOf(await execute(params));
    } catch (e, stackTrace) {
      logger(
        e.toString(),
        error: e,
        stackTrace: stackTrace,
      );

      if (e is CoreException) {
        return failureOf(e);
      }

      return failureOf(
        GenericException(
          message: e.toString(),
          originalError: e,
          originalStackTrace: stackTrace,
        ),
      );
    }
  }
}
