import 'i_platform_features.dart';

class WebPlatformFeatures implements IPlatformFeatures {
  const WebPlatformFeatures();

  @override
  bool get isTorchAvailable => false;

  @override
  bool get isPermissionHandlerAvailable => false;

  @override
  bool get isFileExportAvailable => true;

  @override
  bool get isMobile => false;
}
