import 'dart:typed_data';

abstract interface class IFileExportService {
  /// Saves [bytes] as a file named [fileName] with the given [mimeType].
  ///
  /// On web: triggers a browser download via flutter_file_saver.
  /// On mobile: no-op — file export is not surfaced on mobile.
  Future<void> saveFile({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  });
}
