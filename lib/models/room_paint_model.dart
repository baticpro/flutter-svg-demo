class RoomPaintModel {
  final String path;
  final String fill;

  RoomPaintModel(this.path, this.fill);
}

class RoomPaintWorkspace extends RoomPaintModel {
  final String id;

  RoomPaintWorkspace(String path, String fill, this.id) : super(path, fill);
}
