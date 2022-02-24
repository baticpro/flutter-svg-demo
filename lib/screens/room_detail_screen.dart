import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';
import 'package:testing_app_book_svg_office/ui/room_painter.dart';
import 'package:testing_app_book_svg_office/ui/screen_scaffold.dart';
import 'package:touchable/touchable.dart';

class RoomDetailScreen extends StatefulWidget {
  final RoomModel room;

  const RoomDetailScreen({Key? key, required this.room}) : super(key: key);

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  bool ignoreInteractivity = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SimpleStateManager.of(context).getWorkplaces(widget.room.id);
    });
  }

  void setIgnoreInteractivity(bool value) {
    setState(() {
      print(value);
      ignoreInteractivity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = SimpleStateManager.of(context);

    return ScreenScaffold(
      title: widget.room.displayName,
      loading: state.loadingStatus,
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 5,
        onInteractionStart: (_) => setIgnoreInteractivity(true),
        onInteractionEnd: (_) => setIgnoreInteractivity(false),
        child: Center(
          child: SizedBox(
            width: 171,
            height: 228,
            child: IgnorePointer(
              ignoring: ignoreInteractivity,
              child: CanvasTouchDetector(
                builder: (context) => CustomPaint(
                  painter: RoomPainter(
                    onPanStart: () => setIgnoreInteractivity(true),
                    context: context,
                    roomPaints: state.roomPaints,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
