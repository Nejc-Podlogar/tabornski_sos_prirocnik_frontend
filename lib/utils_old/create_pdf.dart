import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tabornski_sos_prirocnik_frontend/utils/pdf_creation/pdfBodyGenerator.dart';
import 'package:tabornski_sos_prirocnik_frontend/utils/pdf_creation/pdf_handler_factory.dart';


enum PdfType {
  semaphoreFlags,
  semaphoreLetters,
  morseCode,
  morseCodeLetters,
  topoCharacters
}


class CreatePdf {
  
  
  Future<pw.Widget> createBody(PdfType pdfType, dynamic data) async {
    switch (pdfType) {
      case PdfType.semaphoreFlags:
        final images = data as List<String>;
        return await PdfBodyGenerator.generateSemaphoreFlagsBody(images);
      case PdfType.morseCode:
        final morseCode = data as String;
        return await PdfBodyGenerator.generateMorseCodeBody(morseCode);
      default:
        return pw.Center(
          child: pw.Text(
            'There is no data to generate the pdf document from.',
            style: const pw.TextStyle(fontSize: 11),
          ),
        );
      
    }
  }
  
  

  Future<void> createPdf({ required dynamic data, required String title, required PdfType pdfType}) async {
    final fontData =  await rootBundle.load('assets/fonts/JetBrainsMono/JetBrainsMonoNL-Regular.ttf');
    final tff = pw.Font.ttf(fontData);

    final rskLogo = pw.MemoryImage(
      (await rootBundle.load('assets/images/rsk_logo.png')).buffer.asUint8List(),
    );

    final appLogo = pw.MemoryImage(
      (await rootBundle.load('assets/images/taborniski_sos_prirocnik_logo.png')).buffer.asUint8List(),
    );

    final body = await createBody(pdfType, data);


    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
          pw.Padding(
            padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(height: 20),
                  body
                ],
              )

          ),
          ];
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(top: 20),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Created by Taborniski SOS Priročnik app',
                  style: pw.TextStyle(fontSize: 9, font: tff, fontWeight: pw.FontWeight.normal),
                ),
                pw.Text(
                  'by Nejc Podlogar ©${DateTime.now().year}',
                  style: pw.TextStyle(fontSize: 7, font: tff, fontWeight: pw.FontWeight.normal ),
                ),
              ]
            ),
          );
        },
        header: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(rskLogo, width: 50, height: 50),
                  pw.Text(
                    title ,
                    style: pw.TextStyle(fontSize: 18, font: tff, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Image(appLogo, width: 50, height: 50),
                ],
              ),
              pw.Divider(),
            ]
          );
        },
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
      ),
    );

    final pdfBytes = await pdf.save();

    final pdfHandler = PdfHandlerFactory.getHandler();

    await pdfHandler.saveAndLaunchFile(pdfBytes, 'example.pdf');

  }
}