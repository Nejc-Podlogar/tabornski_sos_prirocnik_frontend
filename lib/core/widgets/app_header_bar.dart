import 'package:flutter/material.dart';

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
              icon: const Icon(Icons.chevron_left,
                  color: AppColors.textSecondary, size: 24),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : Padding(
              padding: const EdgeInsets.only(left: AppSpacing.base),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.surface,
                child: Icon(Icons.person,
                    color: AppColors.primaryLight, size: 18),
              ),
            ),
      title: Text(title,
          style: AppTypography.overline.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryLight,
            letterSpacing: 0,
          )),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined,
              color: AppColors.textSecondary, size: 24),
          onPressed: onSettingsPressed,
        ),
      ],
    );
  }
}
