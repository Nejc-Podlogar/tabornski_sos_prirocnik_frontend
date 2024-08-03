import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'pdf_handler.dart';

class PdfHandlerMobile implements PdfHandler {
  @override
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    // Use FilePicker to select a directory
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      final file = File('$selectedDirectory/$fileName');
      await file.writeAsBytes(bytes);

      OpenFile.open(file.path);
    } else {
      // User canceled the picker
      print("No directory selected");
    }
  }
}

PdfHandler getPlatformPdfHandler() => PdfHandlerMobile();