import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/models/workplace_model.dart';

class BookModel {
  final String id;
  final WorkplaceModel workspace;
  final RoomModel room;

  const BookModel(
      {required this.workspace, required this.room, required this.id});
}
