import 'pdf_handler.dart';
import 'pdf_handler_stub.dart'
  if (dart.library.io) 'pdf_handler_mobile.dart'
  if (dart.library.html) 'pdf_handler_web.dart';


class PdfHandlerFactory {
  static PdfHandler getHandler() => getPlatformPdfHandler();
}