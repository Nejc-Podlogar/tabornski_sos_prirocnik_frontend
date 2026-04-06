import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_platform_features.dart';

final platformFeaturesProvider = Provider<IPlatformFeatures>(
  (_) => _PlatformFeaturesImpl(),
);

class _PlatformFeaturesImpl implements IPlatformFeatures {
  @override
  bool get isTorchAvailable => !kIsWeb;

  @override
  bool get isPermissionHandlerAvailable => !kIsWeb;
}
