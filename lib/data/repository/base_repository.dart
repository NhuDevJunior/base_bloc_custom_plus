import 'package:bloc_base_source/helper/logger/logger.dart';
import 'package:dio/dio.dart';

import '../../core/common/error_type.dart';
import '../../core/common/result.dart';
import '../remote/dto/model_base_response.dart';

typedef EntityToModelMapper<Entity, Data> = Data? Function(Entity? entity);
typedef SaveResult<Data> = Future Function(Data? data);

abstract class BaseRepository {
  Future<Result<Data>> safeDbCall<Entity, Data>(Future<Entity?> callDb,
      {required EntityToModelMapper<Entity, Data> mapperDb}) async {
    try {
      final response = await callDb;
      if (response != null) {
        AppLog.d("DB success message -> $response");
        return Success(mapperDb.call(response)!);
      } else {
        AppLog.d("DB response is null");
        return Error(ErrorType.GENERIC, "DB response is null!");
      }
    } catch (exception) {
      AppLog.d("DB failure message -> $exception");
      return Error(ErrorType.GENERIC, "Unknown DB error");
    }
  }

  Future<Result<Data>> safeApiCall<Data>(
    Future<ModelBaseResponse<Data>> call, {
    SaveResult<Data>? saveResult,
  }) async {
    AppLog.d("safeApiCall");
    try {
      var response = await call;
      if (response.isSuccess()) {
        await saveResult?.call(response.data);
        return Success(response.data);
      } else if (response.isTokenExpired()) {
        return Error(ErrorType.TOKEN_EXPIRED, response.message ?? "Unknown Error");
      } else {
        // AppLog.e("response.message -> ${response.message}");
        // return Error(ErrorType.GENERIC, response.message ?? "Unknown Error");
        await saveResult?.call(response.data);
        return Success(response.data);
      }
    } on Exception catch (exception) {
      AppLog.e("Api error message -> ${exception.toString()}");
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.cancel:
            return Error(ErrorType.POOR_NETWORK, exception.message);
          case DioErrorType.other:
            return Error(ErrorType.NO_NETWORK, exception.message);

          case DioErrorType.response:
            return Error(ErrorType.GENERIC, exception.message);
        }
      }
      return Error(ErrorType.GENERIC, "Unknown API error");
    }
  }
}
