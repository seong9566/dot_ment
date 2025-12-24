import 'package:dot_ment/core/network/dio_provider.dart';
import 'package:dot_ment/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dot_ment/features/auth/domain/repositories/auth_repository.dart';
import 'package:dot_ment/features/auth/domain/usecases/add_user_usecase.dart';
import 'package:dot_ment/features/auth/domain/usecases/send_verification_code_usecase.dart';
import 'package:dot_ment/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:dot_ment/features/auth/domain/usecases/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers_di.g.dart';

/// Auth Repository Provider
@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(dio);
}

/// Send Verification Code UseCase Provider
@riverpod
SendVerificationCodeUsecase sendVerificationCodeUsecase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SendVerificationCodeUsecase(repository);
}

/// Verify Code UseCase Provider
@riverpod
VerifyCodeUsecase verifyCodeUsecase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return VerifyCodeUsecase(repository);
}

/// Add User UseCase Provider
@riverpod
AddUserUsecase addUserUsecase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AddUserUsecase(repository);
}

/// Login UseCase Provider
@riverpod
LoginUsecase loginUsecase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUsecase(repository);
}
