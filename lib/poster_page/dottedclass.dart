import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DrawDottedhorizontalline extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashwidth = 5, dashSpace = 3, startx = 0;
    final paint = Paint()
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;

    while (startx < size.width) {
      canvas.drawLine(Offset(startx, 0), Offset(startx + dashwidth, 0), paint);
      startx += dashwidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
