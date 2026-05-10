import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_pdf_viewer.dart';
import 'pdf_viewer_mobile.dart';
import 'pdf_viewer_web.dart';

final pdfViewerProvider = Provider<IPdfViewer>(
  (_) => kIsWeb ? PdfViewerWeb() : PdfViewerMobile(),
);
