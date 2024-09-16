import 'package:flutter/material.dart';

class WgCustomThumShape extends SliderComponentShape {
  final double thumbRadius;
  final double borderWidth;

  const WgCustomThumShape({
    this.thumbRadius = 10.0,
    this.borderWidth = 3.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbRadius * 2, thumbRadius * 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = Colors.orange // Circle color
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white // Border color
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    // Draw the filled circle
    canvas.drawCircle(center, thumbRadius, paint);
    // Draw the border circle
    canvas.drawCircle(center, thumbRadius - borderWidth / 2, borderPaint);
  }
}
