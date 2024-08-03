export 'pdf_handler_factory.dart' if (dart.library.io) 'pdf_handler_mobile.dart' if (dart.library.html) 'pdf_handler_web.dart';

abstract class PdfHandler {
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName);
}

