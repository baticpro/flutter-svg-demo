import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/models/book_model.dart';
import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';
import 'package:testing_app_book_svg_office/models/workplace_model.dart';
import 'package:testing_app_book_svg_office/repositories/dummy_api_repository.dart';
import 'package:testing_app_book_svg_office/repositories/dummy_svg_repository.dart';

// For simplicity
// I use simple state manager based on InheritedNotifier,
// it works similar to `provider`
class SimpleStateManager extends InheritedNotifier {
  final Widget child;
  final SimpleStateManagerData data;

  const SimpleStateManager({
    Key? key,
    required this.child,
    required this.data,
  }) : super(key: key, child: child, notifier: data);

  static SimpleStateManagerData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleStateManager>()!
        .data;
  }
}

class SimpleStateManagerData extends ChangeNotifier {
  final DummyApiRepository repository;

  // here we store entities from API
  Map<String, WorkplaceModel> workPlaces = {};
  // here we store entities parsed from SVG
  List<RoomPaintModel> roomPaints = [];
  List<BookModel> bookItems = [];
  List<RoomModel> rooms = [];

  bool loadingStatus = false;

  int activeTabIndex = 0;
  String selectedRoomId = '';

  SimpleStateManagerData(this.repository) {
    getRooms();
  }

  getRooms() async {
    loadingStatus = true;
    notifyListeners();

    rooms = await repository.fetchRooms();
    loadingStatus = false;
    notifyListeners();
  }

  getBookItems() async {
    loadingStatus = true;
    notifyListeners();

    bookItems = await repository.fetchBookItems();
    loadingStatus = false;
    notifyListeners();
  }

  getWorkplaces(String roomId) async {
    loadingStatus = true;
    notifyListeners();

    final workPlacesList = await repository.fetchWorkPlacesByRoomId(roomId);
    for (var element in workPlacesList) {
      workPlaces[element.id] = element;
    }

    roomPaints = await DummySvgRepository().buildRoomPaints(roomId);

    loadingStatus = false;
    notifyListeners();
  }

  book() async {
    final bookItem = await repository.bookWorkplace(selectedRoomId);
    selectedRoomId = '';

    await getWorkplaces(bookItem!.room.id);
    await getBookItems();

    notifyListeners();
  }

  setActiveTabIndex(int i) {
    activeTabIndex = i;
    notifyListeners();
  }

  setSelectedRoomId(String id) {
    selectedRoomId = id;
    notifyListeners();
  }
}
