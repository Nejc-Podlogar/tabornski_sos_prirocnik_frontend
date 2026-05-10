import 'package:flutter/widgets.dart';

abstract interface class IPdfViewer {
  /// Opens the PDF at [assetPath] in a platform-appropriate viewer.
  ///
  /// On mobile: loads asset bytes and pushes a [flutter_pdfview] route
  /// via [navigator].
  /// On web: no-op — browser PDF rendering from assets is unsupported.
  ///
  /// [navigator] is preferred over [BuildContext] to avoid coupling the
  /// abstraction to the widget tree.
  Future<void> open(String assetPath, NavigatorState navigator);
}
