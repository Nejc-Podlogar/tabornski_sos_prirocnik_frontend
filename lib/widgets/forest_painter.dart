import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MountainTreeBorderPainter extends CustomPainter {

  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    final svgPicture = SvgPicture.asset(
      'assets/images/forest_Separator_single.svg',
      width: size.width,
      height: 50,
      color: Colors.white,
    );
    final pictureRecorder = PictureRecorder();
    final canvas2 = Canvas(pictureRecorder);
    for (var i = 0; i < size.width / 50; i++) {
      canvas2.save();
      canvas2.translate(i * 50, 0);
      /*svgPicture.paint(canvas2, Rect.fromLTWH(0, 0, 50, 50));*/
      canvas2.restore();
    }
    final picture = pictureRecorder.endRecording();
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
