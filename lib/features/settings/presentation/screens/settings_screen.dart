import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
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
        title: 'Nastavitve',
        showBackButton: false,
        onSettingsPressed: null,
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
            // Profile hero
            _ProfileHero(
              username: prefs.username,
              onEditTap: () =>
                  context.pushNamed(RouteNames.settingsEditProfile),
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
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Izbriši vse podatke',
            style: AppTypography.cardTitle
                .copyWith(color: AppColors.danger)),
        content: Text(
            'Ta dejanje je nepovratno. Vsi napredki in nastavitve bodo izbrisani.',
            style: AppTypography.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Prekliči',
                style: AppTypography.buttonLabel
                    .copyWith(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Izbriši',
                style: AppTypography.buttonLabel
                    .copyWith(color: AppColors.danger)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      // TODO: GROUP 26 — wire delete-all to AppSeeder reset
    }
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.username, required this.onEditTap});

  final String? username;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
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
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedUserAdd01,
              color: AppColors.primaryLight,
              size: 36
            )
          ),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username ?? 'Taborniški skavt',
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
                  child: Text('SKAVT',
                      style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600)),
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
