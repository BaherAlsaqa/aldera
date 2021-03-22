import 'package:aldera/constants/colors.dart';
import 'package:flutter/material.dart';
class CircleCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    paint.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        secondaryColor,
        primaryColor,
      ],
    ).createShader(rect);
    paint.style = PaintingStyle.fill; // Change this to fill

    canvas.drawCircle(Offset(200, 200), 150, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}