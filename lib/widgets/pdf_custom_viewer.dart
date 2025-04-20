import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_state.dart';

class PDFScreen extends StatefulWidget {
  final String assetPath; // Path to the PDF in the assets folder
  final String title;

  const PDFScreen({Key? key, required this.assetPath, required this.title})
      : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  late PDFViewController pdfController;
  String? filePath;
  String? errorMessage; // Add a variable to store the error message

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.assetPath);
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = '${tempDir.path}/${widget.assetPath.split('/').last}';
      final File tempFile = File(tempPath);
      await tempFile.writeAsBytes(bytes.buffer.asUint8List());
      setState(() {
        filePath = tempFile.path;
        errorMessage = null; // Clear any previous error message
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Cannot open selected PDF, try again.'; // Set error message
      });
      print('Error loading PDF: $e');
    }
  }

  Future<void> sharePDF() async {
    try {
      if (filePath == null) return;
      await Share.shareXFiles([XFile(filePath!)], text: 'Sharing PDF from Taborniski SOS Priročnik app');
    } catch (e) {
      throw 'Problem while sharing the PDF: $e';
    }
  }

  Future<void> downloadPDF() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.assetPath);
      final Uint8List list = bytes.buffer.asUint8List();
      final String fileName = widget.assetPath.split('/').last;

      FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: list);
    } catch (e) {
      throw 'Problem while downloading the PDF: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.read<ThemeBloc>().state is DarkThemeState;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            )
          : filePath == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(children: [
                  PDFView(
                    filePath: filePath!,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: true,
                    pageFling: true,
                    nightMode: false,
                    onRender: (pages) {
                      setState(() {
                        this.pages = pages!;
                        currentPage = 0;
                        isReady = true;
                      });
                    },
                    onViewCreated: (PDFViewController controller) {
                      pdfController = controller;
                    },
                    onPageChanged: (page, _) {
                      setState(() {
                        currentPage = page!;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = 'Cannot open selected PDF, try again.'; // Handle PDF view error
                      });
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = 'Cannot open selected PDF, try again.'; // Handle page-specific error
                      });
                      print('Error on page $page: $error');
                    },
                  ),
                  isReady
                      ? Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              '${currentPage + 1}/$pages',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ]),
      floatingActionButton: (isReady && errorMessage == null)
          ? SpeedDial(
              icon: Icons.more_horiz_outlined,
              iconTheme: const IconThemeData(color: Colors.white),
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
              ],
            )
          : null,
    );
  }
}
