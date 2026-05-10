abstract interface class IPlatformFeatures {
  bool get isTorchAvailable;
  bool get isPermissionHandlerAvailable;
  bool get isFileExportAvailable;
  bool get isMobile;
}
