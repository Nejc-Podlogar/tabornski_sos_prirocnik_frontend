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
import '../../../../core/widgets/section_action_tile.dart';

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
            SectionActionTile(
              icon: HugeIcons.strokeRoundedTranslate,
              title: 'Prevedi',
              subtitle: 'Besedilo → Morse',
              onTap: () => context.goNamed(RouteNames.morseTranslator),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionActionTile(
              icon: HugeIcons.strokeRoundedBook01,
              title: 'Učenje',
              subtitle: 'Vaje in urjenje',
              onTap: () => context.goNamed(RouteNames.morseExerciseSelector),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionActionTile(
              icon: HugeIcons.strokeRoundedLeftToRightListTriangle,
              title: 'Morsejeva abeceda',
              subtitle: 'Vsi znaki',
              onTap: () => context.goNamed(RouteNames.morseMaterials),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionActionTile(
              icon: HugeIcons.strokeRoundedFlashlight,
              title: 'Svetilka',
              subtitle: 'Oddajanje Morse kode s svetilko',
              onTap: () => context.pushNamed(RouteNames.morseFlashlight),
            ),
          ],
        ),
      ),
    );
  }
}
