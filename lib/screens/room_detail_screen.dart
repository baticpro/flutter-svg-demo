import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/config/colors.dart';
import 'package:testing_app_book_svg_office/custom/clip_svg_path.dart';
import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/models/room_paint_model.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';
import 'package:testing_app_book_svg_office/ui/room_painter.dart';
import 'package:testing_app_book_svg_office/ui/screen_scaffold.dart';

class RoomDetailScreen extends StatefulWidget {
  final RoomModel room;

  const RoomDetailScreen({Key? key, required this.room}) : super(key: key);

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // load workspaces based on room id
      SimpleStateManager.of(context).getWorkplaces(widget.room.id);
    });
  }

  Color calculateClippedPathColor(
    RoomPaintModel roomPaintModel,
  ) {
    // if we found workspace on image
    if (roomPaintModel is RoomPaintWorkspace) {
      final state = SimpleStateManager.of(context);
      final model = state.workPlaces[roomPaintModel.id];

      // if it's selected
      if (state.selectedRoomId == roomPaintModel.id) {
        return AppColors.workspaceActive;
      }

      // if booked or not
      return model!.isBooked ? AppColors.workspaceBooked : AppColors.workspace;
    }

    return Colors.transparent;
  }

  void onWorkspacePaintTapped(RoomPaintModel roomPaintModel) {
    if (roomPaintModel is! RoomPaintWorkspace) return;

    final state = SimpleStateManager.of(context);
    final model = state.workPlaces[roomPaintModel.id]!;

    if (model.isBooked) return;

    state.setSelectedRoomId(model.id);
  }

  void book() async {
    final state = SimpleStateManager.of(context);
    await state.book();

    // not beauty ))) but on this stage I don't have enough time -)))
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Бронирование успешно!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Забронировать ещё'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Завершить'),
                onPressed: () {
                  Navigator.of(context).pop();
                  state.setActiveTabIndex(1);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = SimpleStateManager.of(context);

    return ScreenScaffold(
      title: widget.room.displayName,
      loading: state.loadingStatus,
      child: Stack(
        children: [
          InteractiveViewer(
            minScale: 0.1,
            maxScale: 5,
            child: Center(
              child: SizedBox(
                width: 171, // but we can parse size from svg tag
                height: 228,
                child: Stack(
                  children: state.roomPaints
                      .map((e) => ClipPath(
                            clipper: ClipSvgPath(e),
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: RoomPainter(
                                    context: context,
                                    roomPaint: e,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => onWorkspacePaintTapped(e),
                                  child: Container(
                                    color: calculateClippedPathColor(e),
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          if (state.selectedRoomId.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: book,
                child: const Text('Подтвердить'),
              ),
            )
        ],
      ),
    );
  }
}
