import 'package:aldera/constants/colors.dart';
import 'package:flutter/material.dart';
class AccountCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    paint.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        secondaryColor,
        primaryColor,
      ],
    ).createShader(rect);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, (size.height) * 0.05);
    path.quadraticBezierTo(
        size.width / 2, size.height / 3.50, size.width, (size.height) * 0.26);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}