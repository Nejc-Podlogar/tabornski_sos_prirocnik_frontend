import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../providers/post_provider.dart';
import '../widgets/news_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 1:
              context.goNamed(RouteNames.morse);
            case 2:
              context.goNamed(RouteNames.semaphore);
            case 3:
              context.goNamed(RouteNames.orientation);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedDiamond,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // News card
            postAsync.when(
              data: (post) => post != null
                  ? NewsCard(post: post)
                  : const _NewsEmptyState(),
              loading: () => const _NewsLoadingState(),
              error: (_, __) => const _NewsEmptyState(),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Section shortcuts
            Text(
              'RAZDELKI',
              style: AppTypography.overline.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            _SectionTile(
              icon: HugeIcons.strokeRoundedWifi01,
              label: 'Morse',
              subtitle: 'SIGNALNA KODA',
              onTap: () => context.goNamed(RouteNames.morse),
            ),
            const SizedBox(height: AppSpacing.sm),
            _SectionTile(
              icon: HugeIcons.strokeRoundedFlag01,
              label: 'Semafor',
              subtitle: 'VIZUALNA KOMUNIKACIJA',
              onTap: () => context.goNamed(RouteNames.semaphore),
            ),
            const SizedBox(height: AppSpacing.sm),
            _SectionTile(
              icon: HugeIcons.strokeRoundedCompass,
              label: 'Orientacija',
              subtitle: 'NAVIGACIJA',
              onTap: () => context.goNamed(RouteNames.orientation),
            ),
            const SizedBox(height: AppSpacing.sm),
            _SectionTile(
              icon: HugeIcons.strokeRoundedUser,
              label: 'Profil',
              subtitle: 'MOJ PROFIL',
              onTap: () => context.goNamed(RouteNames.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  const _SectionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  final List<List<dynamic>> icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: HugeIcon(
                  icon: icon,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.buttonLabel.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.caption.copyWith(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // Trailing arrow
            const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsEmptyState extends StatelessWidget {
  const _NewsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const HugeIcon(
            icon: HugeIcons.strokeRoundedWifiOff01,
            color: AppColors.textTertiary,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Novice niso na voljo',
            style: AppTypography.body.copyWith(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsLoadingState extends StatelessWidget {
  const _NewsLoadingState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
