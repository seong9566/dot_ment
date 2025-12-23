import 'package:dio/dio.dart';

/// 에러 메시지를 사용자에게 보여줄 형태로 변환하는 유틸리티
String handleError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '연결 시간이 초과되었습니다. 네트워크 상태를 확인해주세요.';
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          return data['message'] as String;
        }
        return '서버에서 오류가 발생했습니다. (Code: ${error.response?.statusCode})';
      default:
        return '네트워크 오류가 발생했습니다.';
    }
  }
  return error.toString();
}
