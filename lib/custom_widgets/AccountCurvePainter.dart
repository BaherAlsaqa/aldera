import 'package:aldera/constants/colors.dart';
import 'package:flutter/material.dart';
class AccountCurvePainter extends CustomPainter {
  double moveTo;
  double pathX2;
  double pathY2;
  AccountCurvePainter({this.moveTo = 0.05, this.pathX2 = 3.50, this.pathY2 = 0.26});
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

    path.moveTo(0, (size.height) * moveTo);
    path.quadraticBezierTo(
        size.width / 2, size.height / pathX2, size.width, (size.height) * pathY2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}