import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_permission_service.dart';
import 'permission_service_mobile.dart';
import 'permission_service_web.dart';

final permissionServiceProvider = Provider<IPermissionService>(
  (_) =>
      kIsWeb ? PermissionServiceWeb() : PermissionServiceMobile(),
);
