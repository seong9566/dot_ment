/// API 공용 응답 구조
class BaseResponse<T> {
  const BaseResponse({
    required this.message,
    required this.data,
    required this.code,
  });

  final String message;
  final T? data;
  final int code;

  bool get isSuccess => code == 200;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    return BaseResponse<T>(
      message: json['message'] as String,
      data: fromJsonT != null ? fromJsonT(json['data']) : json['data'] as T?,
      code: json['code'] as int,
    );
  }
}
