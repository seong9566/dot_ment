import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// 앱 전역 에러 타입 정의
@freezed
class Failure with _$Failure {
  const factory Failure.serverError(String message) = ServerFailure;
  const factory Failure.networkError() = NetworkFailure;
  const factory Failure.unauthorizedError() = UnauthorizedFailure;
  const factory Failure.notFoundError() = NotFoundFailure;
  const factory Failure.unknownError(String message) = UnknownFailure;
}

