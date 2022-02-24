import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';
import 'package:touchable/touchable.dart';

class RoomPainter extends CustomPainter {
  final BuildContext context;
  final List<RoomPaintModel> roomPaints;
  final Function onPanStart;

  RoomPainter({
    required this.context,
    required this.roomPaints,
    required this.onPanStart,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    myCanvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.amber,
      onPanStart: (_) {
        print('tess');
        onPanStart();
      },
    );

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    for (var roomPaint in roomPaints) {
      Path path = parseSvgPath(roomPaint.path);
      final color = roomPaint.fill.replaceAll('#', '');
      paint.color = Color(int.parse("0xFF$color"));

      myCanvas.drawPath(
        path,
        paint,
        onTapDown: (details) {
          print(roomPaint.path);
        },
        onPanStart: (_) {
          print('tess');
          onPanStart();
        },
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
