class RoomModel {
  final String id;
  final String name;

  String get displayName => name + ' ' + id;

  const RoomModel({required this.id, required this.name});
}
