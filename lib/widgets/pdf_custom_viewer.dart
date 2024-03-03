import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFScreen extends StatefulWidget {
  final String path;
  final String title;

  const PDFScreen({Key? key, required this.path, required this.title})
      : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> sharePDF() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.path);
      final Directory tempDir = await getTemporaryDirectory();
      // get file name from path the last string after the last '/'
      final String fileName = widget.path.split('/').last;
      final File tempFile = File('${tempDir.path}/${fileName}');
       await tempFile.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

       await Share.shareFiles([tempFile.path], text: 'Sharing PDF from Taborniski SOS Priročnik app');
    } catch (e) {
      throw 'Problem while sharing the PDF: $e';
    }
  }

  Future<void> downloadPDF() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.path);
      final Directory tempDir = await getTemporaryDirectory();
      // get file name from path the last string after the last '/'
      final String fileName = widget.path.split('/').last;
      final Uint8List list = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: list);


    } catch (e) {
      throw 'Problem while downloading the PDF: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: [
        InteractiveViewer(
          minScale: 1.0,
          maxScale: 3.0,
            child: PDF(
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: false,
              onRender: (_pages) {
                setState(() {
                  currentPage = 1;
                  pages = _pages!;
                  isReady = true;
                });
              },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  currentPage = page! + 1;
                });
              },
            ).fromAsset(widget.path)
        ),
        isReady
            ? Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey[200],
              child: Text(
                '$currentPage/$pages',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            )
        )
            : Container(),
      ]),
      floatingActionButton: isReady
          ? SpeedDial(
              icon: Icons.more_horiz_outlined,
              activeIcon: Icons.close,
              mini: false,
              spaceBetweenChildren: 4,
              renderOverlay: false,
              useRotationAnimation: true,
              elevation: 8,
              animationCurve: Curves.easeInOut,
              isOpenOnStart: false,
              closeManually: false,
              buttonSize: const Size(48.0, 48.0),
              childrenButtonSize: const Size(45.0, 45.0),
              backgroundColor: Theme.of(context).hintColor,
              children: <SpeedDialChild>[
                  SpeedDialChild(
                    child: const Icon(Icons.share, size: 20),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    label: 'Share the PDF',
                    onTap: () => sharePDF(),
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.download, size: 20),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    label: 'Download',
                    onTap: () => downloadPDF(),
                  ),
                ])
          : null,
    );
  }
}
