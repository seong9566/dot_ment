import 'package:dio/dio.dart';

/// API 요청/응답 인터셉터
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 요청 전 처리 로직
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 응답 후 처리 로직
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 에러 처리 로직
    super.onError(err, handler);
  }
}

