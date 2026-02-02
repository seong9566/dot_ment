import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dot_ment/features/auth/domain/repositories/token_repository.dart';
import 'package:logger/logger.dart';

/// API 요청/응답 로깅 및 토큰 관리 인터셉터
class ApiInterceptor extends Interceptor {
  ApiInterceptor(this._tokenRepository, this._dio);

  final TokenRepository _tokenRepository;
  final Dio _dio;
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  bool _isRefreshing = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenRepository.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    final message = [
      'BaseUrl : ${options.baseUrl}',
      'Method : ${options.method}',
      'API : ${options.path}',
      'queryParam : ${options.queryParameters}',
      'body : ${options.data}',
    ].join(' , ');

    _logger.i('🚀 [API Request] $message');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('✅ [API Response] ${jsonEncode(response.data)}');
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _logger.w('🔐 [401 Unauthorized] Attempting token refresh...');
      _isRefreshing = true;

      try {
        final refreshToken = await _tokenRepository.getRefreshToken();
        if (refreshToken == null) {
          throw DioException(requestOptions: err.requestOptions);
        }

        // TODO: 리프레시 API 엔드포인트에 맞게 수정 필요
        final response = await _dio.post(
          'v1/login/refresh', // 예시 경로
          data: {'refresh': refreshToken},
        );

        if (response.statusCode == 200) {
          final newAccessToken = response.data['data']['access'];
          final newRefreshToken = response.data['data']['refresh'];

          await _tokenRepository.saveAccessToken(newAccessToken);
          await _tokenRepository.saveRefreshToken(newRefreshToken);

          // 실패했던 요청 재시도
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          final clonedRequest = await _dio.fetch(options);
          return handler.resolve(clonedRequest);
        }
      } catch (e) {
        _logger.e(
          '❌ [Token Refresh Failed] Clearing tokens and logout.',
          error: e,
        );
        await _tokenRepository.clearTokens();
        // TODO: 전역 상태 업데이트 및 로그인 화면으로 이동 처리 필요
      } finally {
        _isRefreshing = false;
      }
    }

    _logger.e(
      '❌ [API Error] Method: ${err.requestOptions.method}, Path: ${err.requestOptions.path}\n'
      'Status Code: ${err.response?.statusCode}\n'
      'Message: ${err.message}\n'
      'Data: ${jsonEncode(err.response?.data)}',
    );
    return handler.next(err);
  }
}
