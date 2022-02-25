import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';

class ClipSvgPath extends CustomClipper<Path> {
  final RoomPaintModel roomPaintModel;

  ClipSvgPath(this.roomPaintModel);

  @override
  Path getClip(Size size) {
    return parseSvgPath(roomPaintModel.path);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
