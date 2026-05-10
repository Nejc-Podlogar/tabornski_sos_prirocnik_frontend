import 'dart:typed_data';

import 'i_file_export_service.dart';

/// Mobile stub — file export is a web-only feature ([isFileExportAvailable]
/// is false on mobile). This implementation is never called in practice.
class FileExportServiceMobile implements IFileExportService {
  @override
  Future<void> saveFile({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {}
}
