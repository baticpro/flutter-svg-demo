import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/models/room_model.dart';
import 'package:testing_app_book_svg_office/screens/history_screen.dart';
import 'package:testing_app_book_svg_office/screens/room_detail_screen.dart';
import 'package:testing_app_book_svg_office/screens/rooms_screen.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';

// for simplicity I just build nested navigation for room stack
final List<Widget> _navigationStacks = [
  Navigator(
    initialRoute: '/',
    onGenerateRoute: (routeSettings) {
      if (routeSettings.name == '/detail') {
        final room = (routeSettings.arguments as Map)['room'] as RoomModel;
        return MaterialPageRoute(
            builder: (c) => RoomDetailScreen(
                  room: room,
                ));
      }

      return MaterialPageRoute(builder: (c) => const RoomsScreen());
    },
  ),
  const HistoryScreen(),
];

class BottomTabNavigation extends StatefulWidget {
  const BottomTabNavigation({Key? key}) : super(key: key);

  @override
  _BottomTabNavigationState createState() => _BottomTabNavigationState();
}

class _BottomTabNavigationState extends State<BottomTabNavigation> {
  void _onItemTapped(int index) {
    SimpleStateManager.of(context).setActiveTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final state = SimpleStateManager.of(context);

    return Scaffold(
      body: _navigationStacks.elementAt(state.activeTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.activeTabIndex, //New
        selectedItemColor: Colors.black87,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
