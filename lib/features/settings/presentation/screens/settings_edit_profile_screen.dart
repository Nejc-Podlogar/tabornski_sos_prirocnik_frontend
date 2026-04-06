import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../providers/user_preferences_provider.dart';

class SettingsEditProfileScreen extends ConsumerStatefulWidget {
  const SettingsEditProfileScreen({super.key});

  @override
  ConsumerState<SettingsEditProfileScreen> createState() =>
      _SettingsEditProfileScreenState();
}

class _SettingsEditProfileScreenState
    extends ConsumerState<SettingsEditProfileScreen> {
  late final TextEditingController _nameController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final prefs =
        ref.read(userPreferencesProvider).valueOrNull;
    _nameController =
        TextEditingController(text: prefs?.username ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    final current =
        await ref.read(userPreferencesProvider.future);
    await ref
        .read(userPreferencesProvider.notifier)
        .save(current.copyWith(username: _nameController.text.trim()));
    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Uredi profil',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),

            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundColor: AppColors.primaryDark,
                  child: SizedBox(
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
            // TODO: GROUP 25+ — wire avatar tap to image picker

            const SizedBox(height: AppSpacing.xxl),

            // Name field
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

            const Spacer(),

            PrimaryCtaButton(
              label: 'Shrani',
              onPressed: _isSaving ? null : _save,
              isLoading: _isSaving,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
