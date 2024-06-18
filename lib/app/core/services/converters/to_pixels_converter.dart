import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_package;

import 'text_to_picture_converter.dart';

class ToPixelsConverter {
  final String string;
  final bool border;
  final double canvasSize;

  ToPixelsConverter({
    required this.string,
    required this.canvasSize,
    this.border = false,
  });

  // factory ToPixelsConverter.fromString({
  //   required this.string,
  //   required this.canvasSize,
  //   this.border = false,
  // })

  // factory ToPixelsConverter.fromCanvas({required this.canvas, this.canvasSize,});

  Future<ToPixelsConversionResult> convert() async {
    final ui.Picture picture = TextToPictureConverter.convert(
      text: string,
      canvasSize: canvasSize,
      border: border,
    );
    final ByteData? imageBytes = await _pictureToBytes(picture);
    if (imageBytes == null) {
      log('Error converting picture to bytes, retorno nulo!',
          name: 'ToPixelsConverter');
      return ToPixelsConversionResult(imageBytes: ByteData(0), pixels: []);
    }
    final List<List<ui.Color>> pixels = _bytesToPixelArray(imageBytes);
    return ToPixelsConversionResult(imageBytes: imageBytes, pixels: pixels);
  }

  Future<ByteData?> _pictureToBytes(ui.Picture picture) async {
    final ui.Image img =
        await picture.toImage(canvasSize.toInt(), canvasSize.toInt());
    return await img.toByteData(format: ui.ImageByteFormat.png);
  }

  List<List<Color>> _bytesToPixelArray(ByteData imageBytes) {
    var values = imageBytes.buffer.asUint8List();
    image_package.Image? decodedImage = image_package.decodeImage(values);
    List<List<Color>> pixelArray = List.generate(canvasSize.toInt(),
        (_) => List.filled(canvasSize.toInt(), Colors.white));

    for (int i = 0; i < canvasSize.toInt(); i++) {
      for (int j = 0; j < canvasSize.toInt(); j++) {
        var pixel = decodedImage?.getPixelSafe(i, j);
        if (pixel == null) {
          log('Error converting bytes to pixel array, pixel nulo!',
              name: 'ToPixelsConverter');
          continue;
        }
        var a = pixel.a.toInt();
        var b = pixel.b.toInt();
        var r = pixel.r.toInt();
        var g = pixel.g.toInt();
        pixelArray[i][j] = Color(0xFFFFFFFF & (a << 24 | r << 16 | g << 8 | b));
        // log('Pixel: $r, $g, $b, $a', name: 'ToPixelsConverter');
        // pixelArray[i][j] =
        //     Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), a.toDouble());
      }
    }
    return pixelArray;
  }

  // int _convertColorSpace(int argbColor) {
  //   int r = (argbColor >> 16) & 0xFF;
  //   int b = argbColor & 0xFF;
  //   return (argbColor & 0xFF00FF00) | (b << 16) | r;
  // }
}

class ToPixelsConversionResult {
  ToPixelsConversionResult({
    required this.imageBytes,
    required this.pixels,
  });

  final ByteData imageBytes;
  final List<List<Color>> pixels;
}
