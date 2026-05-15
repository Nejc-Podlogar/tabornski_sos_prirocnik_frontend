import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../providers/user_preferences_provider.dart';

enum _AvatarAction { camera, gallery, remove }

class SettingsEditProfileScreen extends ConsumerStatefulWidget {
  const SettingsEditProfileScreen({super.key});

  @override
  ConsumerState<SettingsEditProfileScreen> createState() =>
      _SettingsEditProfileScreenState();
}

class _SettingsEditProfileScreenState
    extends ConsumerState<SettingsEditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final prefs = ref.read(userPreferencesProvider).valueOrNull;
      _nameController.text = prefs?.username ?? '';
      _roleController.text = prefs?.role ?? '';
      setState(() => _avatarPath = prefs?.avatarId);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  Future<void> _onAvatarTap() async {
    final hasAvatar = _avatarPath != null && File(_avatarPath!).existsSync();

    final action = await showModalBottomSheet<_AvatarAction>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl, AppSpacing.base, AppSpacing.xl, AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.textTertiary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ActionSquare(
                    icon: HugeIcons.strokeRoundedCamera01,
                    color: AppColors.primary,
                    onTap: () =>
                        Navigator.of(ctx).pop(_AvatarAction.camera),
                  ),
                  const SizedBox(width: AppSpacing.base),
                  _ActionSquare(
                    icon: HugeIcons.strokeRoundedImage01,
                    color: AppColors.primary,
                    onTap: () =>
                        Navigator.of(ctx).pop(_AvatarAction.gallery),
                  ),
                  if (hasAvatar) ...[
                    const SizedBox(width: AppSpacing.base),
                    _ActionSquare(
                      icon: HugeIcons.strokeRoundedDelete02,
                      color: AppColors.danger,
                      borderColor: AppColors.danger,
                      onTap: () =>
                          Navigator.of(ctx).pop(_AvatarAction.remove),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (action == null) return;

    if (action == _AvatarAction.remove) {
      if (mounted) setState(() => _avatarPath = null);
      return;
    }

    final source = action == _AvatarAction.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    final picked =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (picked == null) return;

    // Evict stale cache and delete old file before writing the new one.
    if (_avatarPath != null) {
      await FileImage(File(_avatarPath!)).evict();
      final old = File(_avatarPath!);
      if (old.existsSync()) old.deleteSync();
    }

    final appDir = await getApplicationDocumentsDirectory();
    final destPath =
        '${appDir.path}/profile_avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(picked.path).copy(destPath);

    if (mounted) setState(() => _avatarPath = destPath);
  }

  Future<void> _save() async {
    final current = ref.read(userPreferencesProvider).valueOrNull;
    if (current == null) return;

    final newPrefs = current.copyWith(
      username: _nameController.text.trim(),
      role: _roleController.text.trim().isEmpty
          ? null
          : _roleController.text.trim(),
      avatarId: _avatarPath,
    );

    if (mounted) context.pop();
    await ref.read(userPreferencesProvider.notifier).save(newPrefs);
  }

  @override
  Widget build(BuildContext context) {
    final hasAvatar = _avatarPath != null && File(_avatarPath!).existsSync();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Uredi profil',
        showBackButton: true,
        showSettingsButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),

            GestureDetector(
              onTap: _onAvatarTap,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 56,
                    backgroundColor: AppColors.primaryDark,
                    backgroundImage:
                        hasAvatar ? FileImage(File(_avatarPath!)) : null,
                    child: hasAvatar
                        ? null
                        : SizedBox(
                            width: 72,
                            height: 72,
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedUser,
                              color: AppColors.primaryLight,
                              size: 64,
                            ),
                          ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.background, width: 2),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedEdit02,
                          color: AppColors.textPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            TextField(
              controller: _nameController,
              style: AppTypography.body,
              decoration: InputDecoration(
                labelText: 'Ime',
                labelStyle: AppTypography.cardSubtitle,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.primary, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.base),

            TextField(
              controller: _roleController,
              style: AppTypography.body,
              decoration: InputDecoration(
                labelText: 'Naziv',
                labelStyle: AppTypography.cardSubtitle,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.primary, width: 1.5),
                ),
              ),
            ),

            const Spacer(),

            PrimaryCtaButton(
              label: 'Shrani',
              onPressed: _save,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _ActionSquare extends StatelessWidget {
  const _ActionSquare({
    required this.icon,
    required this.color,
    required this.onTap,
    this.borderColor,
  });

  final List<List<dynamic>> icon;
  final Color color;
  final VoidCallback onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? AppColors.textTertiary,
            width: 1.5,
          ),
        ),
        child: Center(
          child: HugeIcon(icon: icon, color: color, size: 28),
        ),
      ),
    );
  }
}
