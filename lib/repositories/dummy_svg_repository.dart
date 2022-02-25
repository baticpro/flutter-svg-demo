import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';
import 'package:xml/xml.dart';

// I assume that svg of every room is stored on backend
// but here I use for simplicity local file
class DummySvgRepository {
  Future<List<RoomPaintModel>> buildRoomPaints(String roomId) async {
    final List<RoomPaintModel> list = [];

    final generalString = await rootBundle.loadString('assets/svg/room.svg');
    final document = XmlDocument.parse(generalString);
    final paths = document.findAllElements('path');

    for (var element in paths) {
      final id = element.getAttribute('id');
      final path = element.getAttribute('d').toString();
      final fill = element.getAttribute('fill').toString();

      final colorHex = fill.replaceAll('#', '');
      final color = Color(int.parse("0xFF$colorHex"));

      if (id != null) {
        list.add(RoomPaintWorkspace(path, color, id));
        continue;
      }

      list.add(RoomPaintModel(path, color));
    }

    return list;
  }
}
