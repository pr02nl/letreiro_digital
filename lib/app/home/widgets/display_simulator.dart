import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../core/services/converters/to_pixels_converter.dart';
import '../../core/ui/painter/display_painter.dart';

class DisplaySimulator extends StatefulWidget {
  final ValueNotifier<String> text;
  final bool border;
  final bool debug;
  static const canvasSize = 50.0;
  const DisplaySimulator({
    super.key,
    required this.text,
    this.border = false,
    this.debug = false,
  });

  @override
  State<DisplaySimulator> createState() => _DisplaySimulatorState();
}

class _DisplaySimulatorState extends State<DisplaySimulator> {
  ByteData? imageBytes;
  List<List<Color>>? pixels;

  @override
  void initState() {
    super.initState();
    _changeText();
    widget.text.addListener(_changeText);
  }

  @override
  void dispose() {
    widget.text.removeListener(_changeText);
    super.dispose();
  }

  void _changeText() {
    _obtainPixelsFromText(widget.text.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _getDebugPreview(),
        const SizedBox(
          height: 48,
        ),
        _getDisplay(context),
      ],
    );
  }

  Widget _getDebugPreview() {
    if (imageBytes == null || widget.debug == false) {
      return const SizedBox.shrink();
    }

    return Image.memory(
      Uint8List.view(imageBytes!.buffer),
      gaplessPlayback: true,
      filterQuality: FilterQuality.none,
      width: DisplaySimulator.canvasSize,
      height: DisplaySimulator.canvasSize,
      color: Colors.black,
    );
  }

  Widget _getDisplay(BuildContext context) {
    if (pixels == null) {
      return const SizedBox.shrink();
    }
    return CustomPaint(
      size: Size.square(MediaQuery.of(context).size.width),
      painter: DisplayPainter(
        pixels: pixels!,
        canvasSize: DisplaySimulator.canvasSize,
      ),
    );
  }

  Future<void> _obtainPixelsFromText(String text) async {
    ToPixelsConversionResult result = await ToPixelsConverter(
      string: text,
      border: widget.border,
      canvasSize: DisplaySimulator.canvasSize,
    ).convert();
    imageBytes = result.imageBytes;
    pixels = result.pixels;
    setState(() {});
  }
}
