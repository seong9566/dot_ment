import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// API 요청/응답 로깅 인터셉터
class ApiInterceptor extends Interceptor {
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final message = [
      'BaseUrl : ${options.baseUrl}',
      'Method : ${options.method}',
      'API : ${options.path}',
      'queryParam : ${options.queryParameters}',
      'body : ${options.data}',
    ].join(' , ');

    _logger.i('🚀 [API Request] $message');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('✅ [API Response] ${jsonEncode(response.data)}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '❌ [API Error] Method: ${err.requestOptions.method}, Path: ${err.requestOptions.path}\n'
      'Status Code: ${err.response?.statusCode}\n'
      'Message: ${err.message}\n'
      'Data: ${jsonEncode(err.response?.data)}',
    );
    super.onError(err, handler);
  }
}
