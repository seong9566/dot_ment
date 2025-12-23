import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';

/// 인증 코드 입력 위젯 (6자리)
class VerificationCodeInput extends StatefulWidget {
  const VerificationCodeInput({
    super.key,
    required this.code,
    required this.onCodeChanged,
    this.hasError = false,
  });

  final String code;
  final ValueChanged<String> onCodeChanged;
  final bool hasError;

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }

    // 초기값 설정
    if (widget.code.isNotEmpty) {
      for (int i = 0; i < widget.code.length && i < 6; i++) {
        _controllers[i].text = widget.code[i];
      }
    }

    // 첫 번째 필드에 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void didUpdateWidget(VerificationCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code) {
      for (int i = 0; i < 6; i++) {
        if (i < widget.code.length) {
          _controllers[i].text = widget.code[i];
        } else {
          _controllers[i].clear();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // 여러 글자 입력 시 마지막 글자만 사용
      _controllers[index].text = value[value.length - 1];
      _controllers[index].selection = TextSelection.collapsed(
        offset: _controllers[index].text.length,
      );
    }

    final newCode = _controllers.map((c) => c.text).join();
    widget.onCodeChanged(newCode);

    // 다음 필드로 이동
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // 백스페이스 시 이전 필드로 이동
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          height: 52,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.background,
              contentPadding: EdgeInsets.zero,
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
              errorBorder: OutlineInputBorder(
                borderRadius: AppRadius.rd10,
                borderSide: const BorderSide(color: AppColors.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: AppRadius.rd10,
                borderSide: const BorderSide(color: AppColors.error, width: 2),
              ),
            ),
            onChanged: (value) => _onChanged(index, value),
            onTap: () {
              _controllers[index].selection = TextSelection.collapsed(
                offset: _controllers[index].text.length,
              );
            },
            onSubmitted: (_) {
              if (index < 5) {
                _focusNodes[index + 1].requestFocus();
              } else {
                _focusNodes[index].unfocus();
              }
            },
          ),
        );
      }),
    );
  }
}
