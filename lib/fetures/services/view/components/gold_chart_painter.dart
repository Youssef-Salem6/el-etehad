import 'package:flutter/material.dart';

class GoldChartPainter extends CustomPainter {
  final bool isDark;

  const GoldChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFf59e0b)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final fillPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFf59e0b).withOpacity(0.3),
              const Color(0xFFf59e0b).withOpacity(0.0),
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Sample data points
    final points = [
      Offset(size.width * 0.1, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.5, size.height * 0.45),
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.7, size.height * 0.35),
      Offset(size.width * 0.8, size.height * 0.25),
      Offset(size.width * 0.9, size.height * 0.3),
    ];

    // Draw filled area
    final fillPath = Path()..moveTo(points.first.dx, size.height);
    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final cp1 = Offset(p1.dx + (p2.dx - p1.dx) / 3, p1.dy);
      final cp2 = Offset(p1.dx + 2 * (p2.dx - p1.dx) / 3, p2.dy);
      fillPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    fillPath.lineTo(size.width * 0.9, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final cp1 = Offset(p1.dx + (p2.dx - p1.dx) / 3, p1.dy);
      final cp2 = Offset(p1.dx + 2 * (p2.dx - p1.dx) / 3, p2.dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    canvas.drawPath(path, paint);

    // Draw points
    for (final point in points) {
      canvas.drawCircle(point, 6, Paint()..color = const Color(0xFFf59e0b));
      canvas.drawCircle(
        point,
        4,
        Paint()..color = isDark ? const Color(0xFF1a1424) : Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
