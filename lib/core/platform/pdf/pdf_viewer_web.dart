import 'package:flutter/widgets.dart';

import 'i_pdf_viewer.dart';

/// Web stub — flutter_pdfview is unavailable in browsers and asset paths
/// cannot be resolved as URLs. Callers are guarded by [isMobile].
class PdfViewerWeb implements IPdfViewer {
  @override
  Future<void> open(String assetPath, NavigatorState navigator) async {}
}
