import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

// import 'package:flutter/material.dart';

class TextToPictureConverter {
  static ui.Picture convert({
    required String text,
    required double canvasSize,
    required bool border,
  }) {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
      recorder,
      ui.Rect.fromPoints(
        const ui.Offset(0.0, 0.0),
        ui.Offset(canvasSize, canvasSize),
      ),
    );

    const ui.Color color = ui.Color.fromARGB(255, 226, 250, 5);

    if (border) {
      final stroke = ui.Paint()
        ..color = color
        ..style = ui.PaintingStyle.stroke;

      canvas.drawRect(
          ui.Rect.fromLTWH(0.0, 0.0, canvasSize, canvasSize), stroke);
    }

    TextSpan span = TextSpan(
      style: const TextStyle(
        fontFamily: "Monospace",
        color: color,
        fontSize: 24,
      ),
      text: text,
    );
    TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
    );

    tp.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );

    final offset =
        Offset((canvasSize - tp.width) * 0.5, (canvasSize - tp.height) * 0.5);
    tp.paint(canvas, offset);

    return recorder.endRecording();
  }
}
