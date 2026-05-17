import 'dart:io' show File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../routing/route_names.dart';
import '../../features/settings/presentation/providers/user_preferences_provider.dart';

class AppHeaderBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppHeaderBar({
    super.key,
    this.title = 'Taborniški S.O.S Priročnik',
    this.showBackButton = false,
    this.showSettingsButton = true,
    this.showBuyMeCoffeeButton = false,
    this.onInfoPressed,
    this.onSettingsPressed,
  });

  final String title;
  final bool showBackButton;
  final bool showSettingsButton;
  final bool showBuyMeCoffeeButton;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onSettingsPressed;

  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.headerBarHeight);

  Widget _buildAvatar(String? avatarPath) {
    if (avatarPath == null || kIsWeb) return _defaultAvatar();
    final file = File(avatarPath);
    if (!file.existsSync()) return _defaultAvatar();
    return CircleAvatar(
      radius: 18,
      backgroundImage: FileImage(file),
    );
  }

  Widget _defaultAvatar() => CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.surface,
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedUser,
          color: AppColors.primary,
          size: 20,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only read avatar when showing the left avatar circle (not the back button).
    final String? avatarPath = showBackButton
        ? null
        : ref.watch(userPreferencesProvider).valueOrNull?.avatarId;

    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppColors.textSecondary,
                size: 24.0,
              ),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(RouteNames.home);
                }
              },
            )
          : Padding(
              padding: const EdgeInsets.only(left: AppSpacing.base),
              child: Center(
                child: _buildAvatar(avatarPath),
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
        if (showSettingsButton)
          IconButton(
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedSettings01,
              color: AppColors.textSecondary,
              size: 24,
            ),
            onPressed: onSettingsPressed,
          )
        else if (showBuyMeCoffeeButton)
          IconButton(
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedCoffee01,
              color: AppColors.textSecondary,
              size: 24,
            ),
            onPressed: () {},
          ),
      ],
    );
  }
}
