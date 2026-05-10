import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../providers/exercise_history_provider.dart';
import '../widgets/exercise_history_card.dart';

class ExerciseHistoryScreen extends ConsumerWidget {
  const ExerciseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSessions = ref.watch(exerciseHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Zgodovina učenja',
        showBackButton: true,
        onSettingsPressed: null,
      ),
      body: asyncSessions.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => Center(
          child: Text(
            'Napaka: $e',
            style: AppTypography.body.copyWith(color: AppColors.danger),
          ),
        ),
        data: (sessions) {
          if (sessions.isEmpty) {
            return const _EmptyState();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.base,
                    AppSpacing.md,
                    AppSpacing.base,
                    AppSpacing.base,
                  ),
                  itemCount: sessions.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, index) =>
                      ExerciseHistoryCard(session: sessions[index]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.base,
                  0,
                  AppSpacing.base,
                  AppSpacing.xl,
                ),
                child: PrimaryCtaButton(
                  label: 'Počisti zgodovino',
                  onPressed: () => _confirmClear(context, ref),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Počisti zgodovino',
          style: AppTypography.cardTitle.copyWith(color: AppColors.danger),
        ),
        content: Text(
          'Vsa zgodovina učenja bo trajno izbrisana.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Prekliči',
              style: AppTypography.buttonLabel
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Izbriši',
              style: AppTypography.buttonLabel
                  .copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(exerciseHistoryProvider.notifier).clearAll();
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedBookOpen01,
              color: AppColors.textTertiary,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.base),
            Text(
              'Še ni zgodovine učenja',
              style: AppTypography.cardTitle
                  .copyWith(color: AppColors.textTertiary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Opravi prvo vajo, da se pojavi tukaj.',
              style: AppTypography.body
                  .copyWith(color: AppColors.textTertiary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
