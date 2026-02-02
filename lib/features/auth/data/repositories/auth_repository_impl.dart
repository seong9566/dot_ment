import 'package:dio/dio.dart';
import 'package:dot_ment/core/network/base_response.dart';
import 'package:dot_ment/features/auth/data/dto/request/add_user_req_dto.dart';
import 'package:dot_ment/features/auth/data/dto/request/save_code_req_dto.dart';
import 'package:dot_ment/features/auth/data/dto/request/verify_code_req_dto.dart';
import 'package:dot_ment/features/auth/data/dto/response/login_res_dto.dart';
import 'package:dot_ment/features/auth/domain/repositories/token_repository.dart';
import 'package:dot_ment/features/auth/domain/repositories/auth_repository.dart';
import 'package:logger/logger.dart';

/// 인증 관련 Repository 구현체
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio, this._tokenRepository);

  final Dio _dio;
  final TokenRepository _tokenRepository;
  final _logger = Logger();

  @override
  Future<bool> sendVerificationCode(String email) async {
    try {
      final reqDto = SaveCodeReqDto(email: email);

      final response = await _dio.post(
        'v1/user/saveCode',
        data: reqDto.toMap(),
      );

      final baseResponse = BaseResponse<String>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => data as String,
      );

      return baseResponse.isSuccess;
    } catch (e) {
      _logger.e('인증 코드 전송 중 에러 발생', error: e);
      rethrow;
    }
  }

  @override
  Future<bool> verifyCode(String email, String code) async {
    try {
      final reqDto = VerifyCodeReqDto(email: email, code: code);

      final response = await _dio.post(
        'v1/user/verifyCode',
        data: reqDto.toMap(),
      );

      final baseResponse = BaseResponse<bool>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => data as bool,
      );

      return baseResponse.isSuccess && (baseResponse.data ?? false);
    } catch (e) {
      _logger.e('인증 코드 확인 중 에러 발생', error: e);
      rethrow;
    }
  }

  @override
  Future<bool> addUser(String email, String password) async {
    try {
      final reqDto = AddUserReqDto(loginId: email, loginPw: password);

      final response = await _dio.post('v1/user/addUser', data: reqDto.toMap());

      final baseResponse = BaseResponse<bool>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => data as bool,
      );

      return baseResponse.isSuccess && (baseResponse.data ?? false);
    } catch (e) {
      _logger.e('사용자 추가(회원가입 완료) 중 에러 발생', error: e);
      rethrow;
    }
  }

  @override
  Future<bool> login(String email, String password) async {
    try {
      final reqDto = AddUserReqDto(loginId: email, loginPw: password);

      final response = await _dio.post('v1/login/access', data: reqDto.toMap());

      final baseResponse = BaseResponse<LoginResDto>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => LoginResDto.fromJson(data as Map<String, dynamic>),
      );

      if (baseResponse.isSuccess && baseResponse.data != null) {
        final loginData = baseResponse.data!;
        await _tokenRepository.saveAccessToken(loginData.access);
        await _tokenRepository.saveRefreshToken(loginData.refresh);
        return true;
      }

      return false;
    } catch (e) {
      _logger.e('로그인 중 에러 발생', error: e);
      rethrow;
    }
  }
}
