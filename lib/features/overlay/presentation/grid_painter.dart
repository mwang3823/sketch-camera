import 'package:flutter/material.dart';

/// A custom painter to draw a 3x3 rule-of-thirds grid.
/// Drawn using semi-transparent white lines.
class GridPainter extends CustomPainter {
  const GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final double stepX = size.width / 3;
    final double stepY = size.height / 3;

    // Vertical grid lines
    canvas.drawLine(Offset(stepX, 0), Offset(stepX, size.height), paint);
    canvas.drawLine(Offset(stepX * 2, 0), Offset(stepX * 2, size.height), paint);

    // Horizontal grid lines
    canvas.drawLine(Offset(0, stepY), Offset(size.width, stepY), paint);
    canvas.drawLine(Offset(0, stepY * 2), Offset(size.width, stepY * 2), paint);
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => false;
}
