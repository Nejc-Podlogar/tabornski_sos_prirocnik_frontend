import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_platform_features.dart';
import 'mobile_platform_features.dart';
import 'web_platform_features.dart';

final platformFeaturesProvider = Provider<IPlatformFeatures>(
  (_) => kIsWeb ? const WebPlatformFeatures() : const MobilePlatformFeatures(),
);
