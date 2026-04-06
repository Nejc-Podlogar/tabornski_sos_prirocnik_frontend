import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/platform/platform_features_provider.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../../domain/value_objects/translation_direction.dart';
import '../providers/morse_translation_provider.dart';

class MorseTranslatorScreen extends ConsumerWidget {
  const MorseTranslatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(morseTranslationProvider);
    final isTorchAvailable =
        ref.watch(platformFeaturesProvider).isTorchAvailable;

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
              options: const ['Besedilo → •—', '•— → Besedilo'],
              selectedIndex:
                  state.direction == TranslationDirection.textToMorse ? 0 : 1,
              onChanged: (_) => ref.read(morseTranslationProvider.notifier).swapDirection(),
            ),
            const SizedBox(height: AppSpacing.base),

            // Input field
            Expanded(
              child: Container(
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
                          state.direction == TranslationDirection.textToMorse
                              ? 'BESEDILO'
                              : 'MORSE',
                          style: AppTypography.overline
                              .copyWith(color: AppColors.textTertiary),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => ref.read(morseTranslationProvider.notifier).clear(),
                          child: const HugeIcon(
                            icon: HugeIcons.strokeRoundedDelete02,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: AppTypography.body
                            .copyWith(color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vnesi besedilo...',
                          hintStyle:
                              TextStyle(color: AppColors.textTertiary),
                        ),
                        onChanged: (text) => ref.read(morseTranslationProvider.notifier).setInput(text),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Output field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.primaryDark, width: 1),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.direction == TranslationDirection.textToMorse
                              ? 'MORSE'
                              : 'BESEDILO',
                          style: AppTypography.overline
                              .copyWith(color: AppColors.primaryLight),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (state.outputText.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: state.outputText));
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
                      child: SingleChildScrollView(
                        child: Text(
                          state.outputText.isEmpty
                              ? 'Prevod se pojavi tukaj...'
                              : state.outputText,
                          style: state.outputText.isEmpty
                              ? AppTypography.body.copyWith(
                                  color: AppColors.textTertiary)
                              : AppTypography.morseSequence.copyWith(
                                  fontSize: 16,
                                  color: AppColors.primaryLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.base),

            // Action buttons
            Row(
              children: [
                // BLISKANJE — hidden on web / when torch unavailable
                if (isTorchAvailable) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          context.goNamed(RouteNames.morseFlashlight),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedFlashlight,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'BLISKANJE',
                            style: AppTypography.buttonLabel.copyWith(
                                color: AppColors.primary, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],

                Expanded(
                  child: PrimaryCtaButton(
                    label: 'Predvajaj',
                    // TODO: GROUP 25 — wire audio transmission
                    onPressed: state.outputText.isNotEmpty ? () {} : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
