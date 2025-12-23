import 'package:dio/dio.dart';
import 'package:dot_ment/core/constants/app_constants.dart';
import 'package:dot_ment/core/network/api_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Dio 인스턴스 제공
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // 커스텀 인터셉터 추가
  dio.interceptors.add(ApiInterceptor());

  return dio;
}
