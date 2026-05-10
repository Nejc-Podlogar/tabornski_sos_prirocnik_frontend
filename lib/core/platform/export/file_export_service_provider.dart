import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'file_export_service_mobile.dart';
import 'file_export_service_web.dart';
import 'i_file_export_service.dart';

final fileExportServiceProvider = Provider<IFileExportService>(
  (_) => kIsWeb ? FileExportServiceWeb() : FileExportServiceMobile(),
);
