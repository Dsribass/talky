import 'package:core/src/utils/exceptions.dart';
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

  AsyncResult<T, TKException> call(P params) async {
    try {
      return successOf(await execute(params));
    } catch (e, stackTrace) {
      logger(
        e.toString(),
        error: e,
        stackTrace: stackTrace,
      );

      if (e is TKException) {
        return failureOf(e);
      }

      return failureOf(
        TKGenericException(
          message: e.toString(),
          originalError: e,
          originalStackTrace: stackTrace,
        ),
      );
    }
  }
}
