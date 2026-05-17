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

class SemaphoreScreen extends ConsumerWidget {
  const SemaphoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Semafor',
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
            case 1:
              context.goNamed(RouteNames.morse);
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
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryDark, AppColors.surface],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SIGNALIZACIJA',
                          style: AppTypography.overline.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                        Text(
                          'SEMAFOR',
                          style: AppTypography.screenTitle.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'A B C D E F G …',
                          style: AppTypography.morseSequence.copyWith(
                            color: AppColors.primaryLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedFlag01,
                    color: AppColors.primary,
                    size: 56,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Action tiles
            SectionActionTile(
              icon: HugeIcons.strokeRoundedTranslate,
              title: 'Prevedi',
              subtitle: 'Besedilo ↔ Zastave',
              onTap: () => context.goNamed(RouteNames.semaphoreTranslator),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionActionTile(
              icon: HugeIcons.strokeRoundedBook01,
              title: 'Učenje',
              subtitle: 'Vaje in urjenje',
              onTap: () =>
                  context.goNamed(RouteNames.semaphoreExerciseSelector),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionActionTile(
              icon: HugeIcons.strokeRoundedCode,
              title: 'Referenca',
              subtitle: 'Vsi znaki',
              onTap: () => context.goNamed(RouteNames.semaphoreMaterials),
            ),
          ],
        ),
      ),
    );
  }
}
