import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';

enum AppBarType { leftBack }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar.leftBack({super.key, this.title, this.onBack})
    : type = AppBarType.leftBack;

  final String? title;
  final VoidCallback? onBack;
  final AppBarType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppBarType.leftBack:
        return AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppColors.textPrimary,
            ),
            onPressed: onBack ?? () => context.pop(),
          ),
          title: title != null
              ? Text(
                  title!,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
          centerTitle: true,
        );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
