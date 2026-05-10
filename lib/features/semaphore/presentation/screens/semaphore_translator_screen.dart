import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../providers/semaphore_translation_provider.dart';
import '../widgets/semaphore_flag_display.dart';

class SemaphoreTranslatorScreen extends ConsumerWidget {
  const SemaphoreTranslatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(semaphoreTranslationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Prevajalnik',
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          children: [
            // Direction toggle
            SegmentedControl(
              options: const ['Besedilo → Zastave', 'Zastave → Besedilo'],
              selectedIndex:
                  state.direction == TranslationDirection.textToMorse ? 0 : 1,
              onChanged: (_) =>
                  ref.read(semaphoreTranslationProvider.notifier).swapDirection(),
            ),
            const SizedBox(height: AppSpacing.base),

            // Input field
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'BESEDILO',
                        style: AppTypography.overline
                            .copyWith(color: AppColors.textTertiary),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => ref
                            .read(semaphoreTranslationProvider.notifier)
                            .clear(),
                        child: const HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete02,
                          color: AppColors.textTertiary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    textCapitalization: TextCapitalization.characters,
                    style: AppTypography.body
                        .copyWith(color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Vnesi besedilo...',
                      hintStyle: TextStyle(color: AppColors.textTertiary),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (text) => ref
                        .read(semaphoreTranslationProvider.notifier)
                        .setInput(text),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Output — flag images
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryDark, width: 1),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ZASTAVE',
                          style: AppTypography.overline
                              .copyWith(color: AppColors.primaryLight),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            final chars = state.entries
                                .map((e) => e.character)
                                .join();
                            if (chars.isNotEmpty) {
                              Clipboard.setData(ClipboardData(text: chars));
                            }
                          },
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedCopy01,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Expanded(
                      child: state.entries.isEmpty
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Zastave se pojavijo tukaj...',
                                style: AppTypography.body
                                    .copyWith(color: AppColors.textTertiary),
                              ),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.entries.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: AppSpacing.sm),
                              itemBuilder: (_, i) {
                                final entry = state.entries[i];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SemaphoreFlagDisplay(
                                      flagImagePath: entry.flagImagePath,
                                      size: 96,
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      entry.character,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
