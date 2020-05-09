import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double value;

  ProgressPainter(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    print(value);
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(36)),
        paint);
    var _paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(
                5, 5, (size.width - 10) * value / 100, size.height - 10),
            Radius.circular(36)),
        _paint);
    final span = TextSpan(
        text: "${value.floor()} %", style: const TextStyle(fontSize: 16));
    TextPainter(text: span, textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas,
          Offset((size.width / 2 - 10) * (value) / 100, size.height / 2 - 11));
    final values = [0.2, 0.4, 0.6, 0.8];
    for (final _value in values) {
      final _color = value / 100 < _value ? Colors.black : Colors.white;
      final _linePaint = Paint()
        ..color = _color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(size.width * _value, 5),
          Offset(size.width * _value, size.height - 5), _linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
