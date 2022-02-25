import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';

class RoomPainter extends CustomPainter {
  final BuildContext context;
  final RoomPaintModel roomPaint;

  RoomPainter({
    required this.context,
    required this.roomPaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = parseSvgPath(roomPaint.path);

    // set initial color
    paint.color = roomPaint.color;

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
