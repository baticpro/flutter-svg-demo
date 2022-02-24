import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/models/book_model.dart';
import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';
import 'package:testing_app_book_svg_office/models/workplace_model.dart';
import 'package:testing_app_book_svg_office/repositories/dummy_api_repository.dart';
import 'package:testing_app_book_svg_office/repositories/paint_repository.dart';

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
  final DummyRepository repository;

  List<WorkplaceModel> workPlaces = [];
  List<RoomPaintModel> roomPaints = [];
  List<BookModel> bookItems = [];
  List<RoomModel> rooms = [];

  bool loadingStatus = false;

  int activeTabIndex = 0;

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

    workPlaces = await repository.fetchWorkPlacesByRoomId(roomId);
    roomPaints = await PaintRepository().buildRoomPaints(roomId);

    loadingStatus = false;
    notifyListeners();
  }

  book(String workPlaceId) async {
    final bookItem = await repository.bookWorkplace(workPlaceId);

    await getWorkplaces(bookItem!.room.id);
    await getBookItems();

    // of course this only for demo :-D
    setActiveTabIndex(1);

    notifyListeners();
  }

  setActiveTabIndex(int i) async {
    activeTabIndex = i;
    notifyListeners();
  }
}
