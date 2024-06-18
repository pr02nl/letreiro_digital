import 'package:flutter/material.dart';

class DisplayPainter extends CustomPainter {
  final List<List<Color>> pixels;
  final double canvasSize;

  DisplayPainter({
    super.repaint,
    required this.pixels,
    required this.canvasSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.black);

    double widthFactor = canvasSize / size.width;

    // Paint rectPaint = Paint()..color = Colors.black;
    Paint circlePaint = Paint()..color = Colors.yellow;

    for (int i = 0; i < pixels.length; i++) {
      for (int j = 0; j < pixels[i].length; j++) {
        // if (pixels[i][j].opacity < 0.3) {
        //   continue;
        // }

        var rectSize = 1.0 / widthFactor;
        var circleSize = 0.3 / widthFactor;

        // canvas.drawRect(
        //   Rect.fromCenter(
        //       center: Offset(i.toDouble() * rectSize + rectSize / 2,
        //           j.toDouble() * rectSize + rectSize / 2),
        //       width: rectSize,
        //       height: rectSize),
        //   rectPaint,
        // );

        canvas.drawCircle(
          Offset(
            i.toDouble() * rectSize + rectSize / 2 - circleSize / 2,
            j.toDouble() * rectSize + rectSize / 2 - circleSize / 2,
          ),
          circleSize,
          circlePaint..color = pixels[i][j],
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
