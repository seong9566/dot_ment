import 'package:flutter/material.dart';

/// 앱 색상 상수
class AppColors {
  AppColors._();

  // Primary Colors
  /// Primary 메인 색상 (8800BB)
  static const primary = Color(0xFF8800BB);

  /// Primary 대비 색상 (F8E8F8)
  static const onPrimary = Color(0xFFF8E8F8);

  // Primary Scale
  /// Primary 100 (F2D9FF) - 가장 밝은 톤
  static const primary100 = Color(0xFFF2D9FF);

  /// Primary 200 (E6C2FF)
  static const primary200 = Color(0xFFE6C2FF);

  /// Primary 300 (D9A1F2)
  static const primary300 = Color(0xFFD9A1F2);

  /// Primary 400 (CC80E5)
  static const primary400 = Color(0xFFCC80E5);

  /// Primary 500 (BB66DD)
  static const primary500 = Color(0xFFBB66DD);

  /// Primary 600 (AA33CC) - 가장 진한 톤
  static const primary600 = Color(0xFFAA33CC);

  // Background Colors
  /// 앱 기본 배경 색상 (F8F5F8)
  static const background = Color(0xFFF8F5F8);

  // Text Colors
  /// 메인 텍스트 색상 (4A4A4A)
  static const textPrimary = Color(0xFF4A4A4A);

  /// PrimaryBackground와 같이 사용되는 Text Color (FAFAF7)
  static const textOnPrimaryContainer = Color(0xFFFAFAF7);

  /// 보조 텍스트 색상
  static const textSecondary = Color(0xFF757575);

  /// 비활성 텍스트 색상
  static const textDisabled = Color(0xFF929292);

  // Semantic Colors
  /// 에러/Red 색상 (FF4F4F)
  static const error = Color(0xFFFF4F4F);

  /// 성공 색상
  static const success = Color(0xFF4CAF50);

  /// 경고 색상
  static const warning = Color(0xFFFF9800);

  /// 정보 색상
  static const info = Color(0xFF2196F3);

  // Neutral Colors
  /// 서페이스 색상
  static const surface = Color(0xFFFFFFFF);

  /// 구분선 색상
  static const divider = Color(0xFFE0E0E0);

  /// 테두리 색상
  static const border = Color(0xFFE0E0E0);
}
