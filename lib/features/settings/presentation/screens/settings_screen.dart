import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/database/seeder/user_preferences_seeder.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../exercise_history/presentation/providers/exercise_history_provider.dart';
import '../../../onboarding/presentation/providers/onboarding_seen_provider.dart';
import '../../domain/value_objects/app_theme_mode.dart';
import '../providers/theme_provider.dart';
import '../providers/user_preferences_provider.dart';

// TODO: GROUP 25 — import platformFeaturesProvider
// import '../../../../core/platform/platform_features_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPreferencesProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: '',
        showBackButton: true,
        showSettingsButton: false,
        showBuyMeCoffeeButton: true,
      ),
      body: prefsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(e.toString(), style: AppTypography.body)),
        data: (prefs) => ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.base),
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/logo/taborniskiSOSprirocnik.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Profile hero
            _SectionLabel('PROFIL'),
            const SizedBox(height: AppSpacing.sm),
            _ProfileHero(
              username: prefs.username,
              role: prefs.role,
              avatarPath: prefs.avatarId,
              onEditTap: () {
                context.pushNamed(RouteNames.settingsEditProfile);
              },
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Preferences section
            _SectionLabel('NASTAVITVE'),
            const SizedBox(height: AppSpacing.sm),

            _SettingsRow(
              icon: SizedBox(
                width: 20,
                height: 20,
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedMoon01,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              title: 'Temni način',
              subtitle: 'Videz aplikacije',
              trailing: Switch(
                value: themeMode == AppThemeMode.dark,
                onChanged: (on) => ref.read(themeModeProvider.notifier)
                    .setThemeMode(
                        on ? AppThemeMode.dark : AppThemeMode.light),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Permissions row — mobile only
            // TODO: GROUP 25 — replace kIsWeb check with
            // ref.watch(platformFeaturesProvider).isPermissionHandlerAvailable
            if (!kIsWeb) ...[
              _SettingsRow(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification01,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                title: 'Dovoljenja',
                subtitle: 'Kamera, obvestila',
                trailing: const Icon(Icons.chevron_right,
                    color: AppColors.textTertiary),
                onTap: () =>
                    context.pushNamed(RouteNames.settingsPermissions),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],

            const SizedBox(height: AppSpacing.xxl),

            // Danger zone
            _DangerZoneCard(
              onDeleteAll: () => _confirmDeleteAll(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteAll(
      BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.dangerSurface,
        title: Text(
          'Izbriši vse podatke',
          style: AppTypography.cardTitle.copyWith(color: AppColors.danger),
        ),
        content: Text(
          'To dejanje je dokončno. '
          'Vsi podatki bodo trajno izbrisani.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Prekliči'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.danger,
            ),
            child: const Text('Izbriši'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    try {
      // 1. Clear exercise history via notifier
      await ref.read(exerciseHistoryProvider.notifier).clearAll();

      // 2. Delete user preferences row — resets onboardingSeen to false
      final db = ref.read(appDatabaseProvider);
      await db.delete(db.userPreferencesTable).go();

      // 3. Restore default preferences only — corpus tables are unaffected
      //    and AppSeeder.run() cannot load assets from a widget context.
      await UserPreferencesSeeder().seed(db);

      // 4. Invalidate providers so router guard re-evaluates onboardingSeen
      ref.invalidate(userPreferencesProvider);
      ref.invalidate(onboardingSeenProvider);

      if (!context.mounted) return;

      // 5. go() replaces the entire stack — prevents pop() emptying the route stack
      context.go('/${RouteNames.onboarding}');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Napaka pri brisanju: $e')),
      );
    }
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.username,
    required this.onEditTap,
    this.role,
    this.avatarPath,
  });

  final String? username;
  final String? role;
  final String? avatarPath;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarPath != null && File(avatarPath!).existsSync();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.primaryDark,
            backgroundImage: hasAvatar ? FileImage(File(avatarPath!)) : null,
            child: hasAvatar
                ? null
                : HugeIcon(
                    icon: HugeIcons.strokeRoundedUserAdd01,
                    color: AppColors.primaryLight,
                    size: 36,
                  ),
          ),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username ?? 'Tabornik',
                    style: AppTypography.cardTitle
                        .copyWith(color: AppColors.primary)),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    role?.isNotEmpty == true ? role! : 'SKAVT',
                    style: AppTypography.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedEdit02,
              color: AppColors.textSecondary,
              size: 20,
            ),
            onPressed: onEditTap,
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTypography.overline);
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(width: AppSpacing.base),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.body),
                  Text(subtitle, style: AppTypography.caption),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _DangerZoneCard extends StatelessWidget {
  const _DangerZoneCard({required this.onDeleteAll});

  final VoidCallback onDeleteAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.dangerSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.danger.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedRestoreBin,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.base),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nevarno območje',
                      style: AppTypography.cardTitle
                          .copyWith(color: AppColors.danger, fontSize: 18)),
                  Text('Nepovratna dejanja',
                      style: AppTypography.cardSubtitle),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.base),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onDeleteAll,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: AppColors.textPrimary,
                shape: const StadiumBorder(),
              ),
              child: Text('IZBRIŠI VSE PODATKE',
                  style: AppTypography.buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
