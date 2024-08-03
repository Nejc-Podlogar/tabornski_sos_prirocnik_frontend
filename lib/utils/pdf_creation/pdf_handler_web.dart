import 'dart:html' as html;
import 'pdf_handler.dart';

class PdfHandlerWeb implements PdfHandler {
  @override
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
  }

}

PdfHandler getPlatformPdfHandler() => PdfHandlerWeb();