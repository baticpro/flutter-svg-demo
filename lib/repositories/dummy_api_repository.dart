import 'package:testing_app_book_svg_office/models/book_model.dart';
import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/models/workplace_model.dart';

// simulate api requests
class DummyRepository {
  final List<WorkplaceModel> _workPlaces = [
    const WorkplaceModel(isBooked: true, id: '001'),
    const WorkplaceModel(isBooked: false, id: '002'),
    const WorkplaceModel(isBooked: false, id: '003'),
    const WorkplaceModel(isBooked: false, id: '004'),
    const WorkplaceModel(isBooked: false, id: '005'),
  ];

  final List<BookModel> _bookItems = [];

  final List<RoomModel> _rooms = [
    const RoomModel(id: '#333', name: 'Кузнецкий Мост')
  ];

  Future<List<RoomModel>> fetchRooms() async {
    await Future.delayed(const Duration(milliseconds: 250));

    return _rooms;
  }

  Future<List<WorkplaceModel>> fetchWorkPlacesByRoomId(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 250));

    return _workPlaces;
  }

  Future<List<BookModel>> fetchBookItems() async {
    await Future.delayed(const Duration(milliseconds: 250));

    return _bookItems;
  }

  Future<BookModel?> bookWorkplace(String workplaceId) async {
    await Future.delayed(const Duration(milliseconds: 250));

    try {
      final workPlace =
          _workPlaces.firstWhere((element) => element.id == workplaceId);
      final index = _workPlaces.indexOf(workPlace);

      _workPlaces[index] = workPlace.copyWith(isBooked: true);

      _bookItems.add(BookModel(
          workspace: workPlace,
          room: _rooms[0],
          id: '#${_bookItems.length + 1}'));

      return _bookItems.last;
    } catch (_) {
      return null;
    }
  }
}
