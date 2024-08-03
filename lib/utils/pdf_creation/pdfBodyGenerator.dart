import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../widgets/MorseCodeCustomDisplay.dart';

class PdfBodyGenerator {
  static Future<pw.Widget> generateSemaphoreFlagsBody(
      List<String> images) async {
    return pw.Center(
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(20),
        child: pw.Wrap(
          direction: pw.Axis.horizontal,
          alignment: pw.WrapAlignment.start,
          crossAxisAlignment: pw.WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: await Future.wait(images.map((String img) async {
            final ByteData imgData = await rootBundle.load(img);
            var loadedImage = pw.MemoryImage(imgData.buffer.asUint8List());

            return pw.Container(
              margin: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Image(
                loadedImage,
                width: 60,
                height: 60,
              ),
            );
          }).toList()),
        ),
      ),
    );
  }

  static Future<pw.Widget> generateMorseCodeBody(String morseCode) async {
    List<pw.Widget> displayElements = [];
    for (int i = 0; i < morseCode.length; i++) {
      String e = morseCode[i];
      if (e == '.') {
        displayElements.add(pw.Container(
          width: 5,
          height: 5,
          decoration: const pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            color: PdfColors.black,
          ),
        ));
      } else if (e == '-') {
        displayElements.add(pw.Container(
          width: 25,
          height: 5,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(3),
            color: PdfColors.black, // Example color
          ),
        ));
      } else if (e == '/') {
        displayElements.add(
          pw.Transform.rotate(
            angle: 45 * 3.14 / 180,
            child: pw.Container(
                width: 20,
                height: 3,
                margin: const pw.EdgeInsets.symmetric(horizontal: 2.0),
                decoration: pw.BoxDecoration(
                  color: PdfColors.black,
                  borderRadius: pw.BorderRadius.circular(3),
                )
            )
          )
        );
      }
      // Add spacing between elements if not the last character and not a space
      if (i < morseCode.length - 1 && morseCode[i + 1] != '/' && e != '/') {
        displayElements.add(pw.SizedBox(width: 8));
      }
    }

    return pw.Wrap(
      alignment: pw.WrapAlignment.start,
      crossAxisAlignment: pw.WrapCrossAlignment.center,
      direction: pw.Axis.horizontal,
      spacing: 1.0,
      runSpacing: 20.0,
      children: displayElements,
    );
  }
}
