import 'dart:io';

import 'package:bloc_base_source/helper/logger/logger.dart';
import 'package:bloc_base_source/helper/logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../data/remote/service/service_constants.dart';
import '../../di/locator.dart';

class DioNetwork {
  Dio getDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ServiceConstants.baseUrl,
      contentType: NetworkRequestValues.contentType,
      sendTimeout: ServiceConstants.timeOut,
      connectTimeout: ServiceConstants.timeOut,
      receiveTimeout: ServiceConstants.timeOut,
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    dio.interceptors.add(_addInterceptor());
    return dio;
  }

  InterceptorsWrapper _addInterceptor() {
    return InterceptorsWrapper(onRequest: (_option, _handler) {
      _option.headers = {
        RequestHeader.tokenKey: token,
        RequestHeader.language: langApp,
      };
      AppLog.d("Request:");
      AppLog.d("Log Base Url request: ${_option.baseUrl}");
      AppLog.d("Log header request: ${_option.headers.toString()}");
      _handler.next(_option);
    }, onResponse: (_response, _handler) {
      AppLog.d(
          "Response: ${_response.data?.toString() ?? _response.statusCode ?? "logResponseInterceptor empty"}");
      _handler.next(_response);
    }, onError: (_error, _handler) {
      AppLog.d("Error: ${_error.error?.toString()}");
      _handler.next(_error);
    });
  }
}
