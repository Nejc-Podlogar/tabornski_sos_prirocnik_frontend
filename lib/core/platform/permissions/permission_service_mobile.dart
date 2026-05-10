import 'package:permission_handler/permission_handler.dart'
    as ph show Permission, PermissionStatus, openAppSettings;

import 'i_permission_service.dart';

class PermissionServiceMobile implements IPermissionService {
  @override
  Future<PermissionStatus> requestCamera() =>
      _map(ph.Permission.camera.request());

  @override
  Future<PermissionStatus> requestStorage() =>
      _map(ph.Permission.storage.request());

  @override
  Future<bool> openAppSettings() => ph.openAppSettings();

  static Future<PermissionStatus> _map(
    Future<ph.PermissionStatus> future,
  ) async {
    final status = await future;
    if (status.isGranted) return PermissionStatus.granted;
    if (status.isPermanentlyDenied) return PermissionStatus.permanentlyDenied;
    return PermissionStatus.denied;
  }
}
