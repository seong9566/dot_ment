import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';

/// 비밀번호 입력 필드 위젯
class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    required this.value,
    required this.onChanged,
    this.hintText = 'Please enter your password',
    this.hasError = false,
    this.errorText,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool hasError;
  final String? errorText;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(PasswordInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _focusNode.unfocus(),
      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: widget.hasError ? widget.errorText : widget.hintText,
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: widget.hasError ? AppColors.error : AppColors.textDisabled,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          Icons.lock_outline,
          color: widget.hasError ? AppColors.error : Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.rd10,
          borderSide: BorderSide(
            color: widget.hasError ? AppColors.error : AppColors.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.rd10,
          borderSide: BorderSide(
            color: widget.hasError ? AppColors.error : AppColors.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.rd10,
          borderSide: BorderSide(
            color: widget.hasError ? AppColors.error : AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
