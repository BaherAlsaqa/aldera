import 'package:aldera/constants/colors.dart';
import 'package:flutter/material.dart';
class CurvePainter extends CustomPainter {
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
        primaryColor,
      ],
    ).createShader(rect);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, (size.height+530) * 0.35);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1.5, size.width, (size.height+530) * 0.32);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}