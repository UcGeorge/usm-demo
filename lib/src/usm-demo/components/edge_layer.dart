import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/fonts.dart';

class EdgeLayer extends StatelessWidget {
  const EdgeLayer({
    super.key,
    required this.size,
    required this.start,
    required this.end,
    required this.color,
    required this.directed,
    required this.weight,
  });

  final Offset end;
  final Size size;
  final Offset start;
  final Color color;
  final bool directed;
  final double? weight;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: RPSCustomPainter(start, end, color, directed, weight),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter(
      this.start, this.end, this.color, this.directed, this.weight);

  final Offset start;
  final Offset end;
  final Color color;
  final bool directed;
  final double? weight;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = color;

    canvas.drawLine(start, end, paint0Stroke);

    if (directed) {
      Path path0 = Path();

      // Draw arrow
      final midpoint = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      final points = calculateArrowPoints(start, midpoint, 20);

      path0.moveTo(midpoint.dx, midpoint.dy);
      path0.lineTo(points[0].dx, points[0].dy);
      path0.lineTo(points[1].dx, points[1].dy);
      path0.close();

      Paint paint0Fill = Paint()
        ..style = PaintingStyle.fill
        ..color = color;
      canvas.drawPath(path0, paint0Fill);
    }

    if (weight != null) {
      final span = TextSpan(
        text: weight.toString(),
        style: AppFonts.nunito.copyWith(
          fontSize: 24,
          color: Colors.black,
        ),
      );

      final textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      final midpoint = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);

      textPainter.paint(canvas, midpoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // Function to calculate the other two points of the triangle arrow
  List<Offset> calculateArrowPoints(
      Offset startPoint, Offset endPoint, double triangleLength) {
    // Calculate the angle of the line
    double angle =
        atan2(endPoint.dy - startPoint.dy, endPoint.dx - startPoint.dx);

    // Calculate the coordinates for the arrow points
    double x1 = endPoint.dx - triangleLength * cos(angle + pi / 6);
    double y1 = endPoint.dy - triangleLength * sin(angle + pi / 6);
    double x2 = endPoint.dx - triangleLength * cos(angle - pi / 6);
    double y2 = endPoint.dy - triangleLength * sin(angle - pi / 6);

    // Return the arrow points as Offset objects
    return [Offset(x1, y1), Offset(x2, y2)];
  }
}
