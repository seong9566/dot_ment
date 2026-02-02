import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_res_dto.freezed.dart';
part 'login_res_dto.g.dart';

@freezed
abstract class LoginResDto with _$LoginResDto {
  const factory LoginResDto({required String access, required String refresh}) =
      _LoginResDto;

  factory LoginResDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResDtoFromJson(json);
}
