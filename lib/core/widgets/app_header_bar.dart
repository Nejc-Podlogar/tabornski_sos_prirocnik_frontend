import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const AppHeaderBar({
    super.key,
    this.title = 'Taborniški S.O.S Priročnik',
    this.showBackButton = false,
    this.onInfoPressed,
    this.onSettingsPressed,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onSettingsPressed;

  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.headerBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppColors.textSecondary,
                size: 24,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : Padding(
              padding: const EdgeInsets.only(left: AppSpacing.base),
              child: Center(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.surface,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
      title: Text(
        title,
        style: AppTypography.overline.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryLight,
          letterSpacing: 0,
        ),
      ),
      actions: [
        IconButton(
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedSettings01,
            color: AppColors.textSecondary,
            size: 24,
          ),
          onPressed: onSettingsPressed,
        ),
      ],
    );
  }
}
