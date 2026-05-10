import 'i_permission_service.dart';

/// Web stub — permission_handler is unavailable in browsers.
/// All permissions are reported as denied; the settings screen is guarded
/// by [isPermissionHandlerAvailable] so this is never surfaced to the user.
class PermissionServiceWeb implements IPermissionService {
  @override
  Future<PermissionStatus> requestCamera() async =>
      PermissionStatus.denied;

  @override
  Future<PermissionStatus> requestStorage() async =>
      PermissionStatus.denied;

  @override
  Future<bool> openAppSettings() async => false;
}
