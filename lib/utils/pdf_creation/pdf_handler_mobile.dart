import 'dart:io';
import 'package:open_filex/open_filex.dart';
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

      OpenFilex.open(file.path);
    } else {
      // User canceled the picker
      print("No directory selected");
    }
  }
}

PdfHandler getPlatformPdfHandler() => PdfHandlerMobile();