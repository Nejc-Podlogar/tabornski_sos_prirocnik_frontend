// This file is intentionally mobile-only.
// Never import this file directly — use
// pdf_viewer_provider.dart which conditionally
// selects the correct implementation.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../widgets/app_header_bar.dart';
import 'i_pdf_viewer.dart';

class PdfViewerMobile implements IPdfViewer {
  @override
  Future<void> open(String assetPath, NavigatorState navigator) async {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();

    await navigator.push<void>(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppHeaderBar(
            title: 'Dokument',
            showBackButton: true,
            onSettingsPressed: null,
          ),
          body: PDFView(pdfData: bytes),
        ),
      ),
    );
  }
}
