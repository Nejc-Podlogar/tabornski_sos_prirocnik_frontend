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

class MorseScreen extends ConsumerWidget {
  const MorseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Morse',
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
            case 2:
              context.goNamed(RouteNames.semaphore);
            case 3:
              context.goNamed(RouteNames.orientation);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero banner
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryDark,
                    AppColors.surface,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MORSEJEVA',
                          style: AppTypography.overline.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                        Text(
                          'ABECEDA',
                          style: AppTypography.screenTitle.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          '•— ••• ••• •—',
                          style: AppTypography.morseSequence.copyWith(
                            color: AppColors.primaryLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedBarcodeScan,
                      color: AppColors.primary,
                      size: 56,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Action tiles
            _ActionTile(
              icon: HugeIcons.strokeRoundedTranslate,
              title: 'Prevedi',
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Besedilo',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowDataTransferHorizontal,
                    color: AppColors.textTertiary,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Morse',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
              onTap: () => context.goNamed(RouteNames.morseTranslator),
            ),
            const SizedBox(height: AppSpacing.md),
            _ActionTile(
              icon: HugeIcons.strokeRoundedBook01,
              title: 'Učenje',
              subtitle: Text(
                'Vaje in urjenje',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              onTap: () => context.goNamed(RouteNames.morseExerciseSelector),
            ),
            const SizedBox(height: AppSpacing.md),
            _ActionTile(
              icon: HugeIcons.strokeRoundedLeftToRightListTriangle,
              title: 'Morsejeva abeceda',
              subtitle: Text(
                'Vsi znaki',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              onTap: () => context.goNamed(RouteNames.morseMaterials),
            ),
            const SizedBox(height: AppSpacing.md),
            _ActionTile(
              icon: HugeIcons.strokeRoundedFlashlight,
              title: 'Svetilka',
              subtitle: Text(
                'Oddajanje Morse kode s svetilko',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              onTap: () => context.pushNamed(RouteNames.morseFlashlight),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final List<List<dynamic>> icon;
  final String title;
  final Widget subtitle;
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
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.buttonLabel.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle,
                ],
              ),
            ),
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
