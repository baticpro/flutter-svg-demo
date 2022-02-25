import 'package:flutter/material.dart';

class RoomPaintModel {
  final String path;
  final Color color;

  RoomPaintModel(this.path, this.color);
}

class RoomPaintWorkspace extends RoomPaintModel {
  final String id;

  RoomPaintWorkspace(String path, Color color, this.id) : super(path, color);
}
