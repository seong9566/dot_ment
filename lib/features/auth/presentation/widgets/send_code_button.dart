import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';

/// 인증 코드 전송 버튼 위젯
class SendCodeButton extends StatelessWidget {
  const SendCodeButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.rd10),
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.email_input_send_code,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textOnPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
      ),
    );
  }
}
