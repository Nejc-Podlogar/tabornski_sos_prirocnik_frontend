enum PermissionStatus { granted, denied, permanentlyDenied }

abstract interface class IPermissionService {
  /// Requests camera permission. Returns current status after the request.
  Future<PermissionStatus> requestCamera();

  /// Requests storage permission. Returns current status after the request.
  Future<PermissionStatus> requestStorage();

  /// Opens the OS app-settings page so the user can grant permissions
  /// that were permanently denied.
  Future<bool> openAppSettings();
}
