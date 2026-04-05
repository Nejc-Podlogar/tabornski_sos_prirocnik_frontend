import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_header_bar.dart';

// TODO: GROUP 25 — import platformFeaturesProvider
// import '../../../../core/platform/platform_features_provider.dart';

// TODO: GROUP 25 — import permissionServiceProvider
// import '../../../../core/platform/permissions/permission_service_provider.dart';

/// Only rendered on mobile — caller must check
/// IPlatformFeatures.isPermissionHandlerAvailable before pushing this route.
class SettingsPermissionsScreen extends StatelessWidget {
  const SettingsPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeaderBar(
        title: 'Dovoljenja',
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl, vertical: AppSpacing.base),
        children: [
          _SectionLabel('SISTEMSKA DOVOLJENJA'),
          const SizedBox(height: AppSpacing.sm),

          // TODO: GROUP 25 — read actual permission status from
          // permissionServiceProvider and update these rows dynamically
          _PermissionRow(
            icon: Icons.camera_alt_outlined,
            title: 'Kamera',
            subtitle: 'Potrebna za skeniranje',
            status: _PermissionStatus.unknown,
            onManage: () {
              // TODO: GROUP 25 — call permissionService.requestCamera()
            },
          ),
          const SizedBox(height: AppSpacing.sm),

          _PermissionRow(
            icon: Icons.notifications_outlined,
            title: 'Obvestila',
            subtitle: 'Novosti in opomniki',
            status: _PermissionStatus.unknown,
            onManage: () {
              // TODO: GROUP 25 — call permissionService.requestNotifications()
            },
          ),
        ],
      ),
    );
  }
}

enum _PermissionStatus { granted, denied, unknown }

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) =>
      Text(label, style: AppTypography.overline);
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.onManage,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final _PermissionStatus status;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    final (statusLabel, statusColor) = switch (status) {
      _PermissionStatus.granted => ('Dovoljeno', AppColors.correct),
      _PermissionStatus.denied => ('Zavrnjeno', AppColors.danger),
      _PermissionStatus.unknown => ('Neznano', AppColors.textTertiary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base, vertical: AppSpacing.sm),
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
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.body),
                Text(subtitle, style: AppTypography.caption),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(statusLabel,
                style: AppTypography.caption
                    .copyWith(color: statusColor)),
          ),
          const SizedBox(width: AppSpacing.sm),
          TextButton(
            onPressed: onManage,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm),
            ),
            child: Text('Upravljaj',
                style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
