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
  });

  final String value;
  final ValueChanged<String> onChanged;

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
    if (oldWidget.value != widget.value &&
        _controller.text != widget.value) {
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
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textDisabled,
        ),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

