import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/features/home/presentation/widgets/channel_app_bar.dart';
import 'package:dot_ment/features/home/presentation/widgets/channel_carousel.dart';
import 'package:dot_ment/features/home/presentation/widgets/channel_card.dart';
import 'package:dot_ment/features/home/presentation/widgets/new_channel_button.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/router/router_path.dart';

/// 채널 리스트 메인 화면
class ChannelListView extends ConsumerWidget {
  const ChannelListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const ChannelAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    const ChannelCarousel(),
                    const SizedBox(height: AppSpacing.lg),
                    ChannelCard(
                      title: 'TanTrainer',
                      subtitle: 'ehxks9180  2025, 12 04 21 : 11',
                      onTap: () => context.go(RouterPath.home),
                    ),
                  ],
                ),
              ),
            ),
            NewChannelButton(
              onPressed: () {
                // TODO: 채널 생성 로직 연동
              },
            ),
          ],
        ),
      ),
    );
  }
}
