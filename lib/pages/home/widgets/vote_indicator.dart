import 'dart:math' as math;
import 'package:flutter/material.dart';

class ProgressIndicatorButton extends StatelessWidget {
  const ProgressIndicatorButton({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final int percentage;

  @override
  Widget build(BuildContext context) {
    const buttonSize = 50.0;
    const borderWidth = 7.0;

    return Stack(
      children: [
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: borderWidth,
            ),
          ),
        ),
        SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: CustomPaint(
            painter: ProgressIndicatorPainter(
              width: borderWidth,
              startAngle: -90,
              sweepAngle: 360 * percentage ~/ 100,
            ),
            child: Center(
              child: Container(
                width: 43,
                height: 43,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  const ProgressIndicatorPainter({
    required this.width,
    required this.startAngle,
    required this.sweepAngle,
  }) : super();

  final double width;
  final int startAngle;
  final int sweepAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final startAngleRad = startAngle * (math.pi / 180.0);
    final sweepAngleRad = sweepAngle * (math.pi / 180.0);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (width / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleRad,
      sweepAngleRad,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
