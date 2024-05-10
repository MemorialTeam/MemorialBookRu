import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (0.7 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = Color.fromRGBO(23, 94, 217, opacity);
    //orig
    // double size = rect.width / 10;
    double size = 4.h;
    double area = size * size;
    double radius = sqrt(area * value / 6);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}