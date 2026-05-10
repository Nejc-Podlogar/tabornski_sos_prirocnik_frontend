// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

import 'i_file_export_service.dart';

class FileExportServiceWeb implements IFileExportService {
  @override
  Future<void> saveFile({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
