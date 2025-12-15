import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Dio 인스턴스 제공
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    // baseUrl: Env.apiUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
    },
  ));

  // Interceptor 추가
  dio.interceptors.add(LogInterceptor(responseBody: true));
  // dio.interceptors.add(AuthInterceptor(ref));

  return dio;
}

