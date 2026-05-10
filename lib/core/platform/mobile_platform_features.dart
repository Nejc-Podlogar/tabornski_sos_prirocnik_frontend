import 'i_platform_features.dart';

class MobilePlatformFeatures implements IPlatformFeatures {
  const MobilePlatformFeatures();

  @override
  bool get isTorchAvailable => true;

  @override
  bool get isPermissionHandlerAvailable => true;

  @override
  bool get isFileExportAvailable => false;

  @override
  bool get isMobile => true;
}
