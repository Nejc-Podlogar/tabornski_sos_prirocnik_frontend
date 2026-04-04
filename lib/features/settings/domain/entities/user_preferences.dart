import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/app_theme_mode.dart';

part 'user_preferences.freezed.dart';

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    required AppThemeMode themeMode,
    String? username,
    String? avatarId,
    required bool onboardingSeen,
  }) = _UserPreferences;
}
