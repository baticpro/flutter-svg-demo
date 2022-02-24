import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';
import 'package:testing_app_book_svg_office/ui/screen_scaffold.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = SimpleStateManager.of(context);

    return ScreenScaffold(
      title: 'Бронирование места в офисе',
      loading: state.loadingStatus,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final room = state.rooms[index];

            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/detail',
                  arguments: {
                    'room': room
                  }), // of course this only for demo :-D
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(15),
                child: Text(
                  room.displayName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          itemCount: state.rooms.length,
        ),
      ),
    );
  }
}
