import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = SimpleStateManager.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('История бронирований'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(state.bookItems[index].id),
          subtitle: Text('Место: ' + state.bookItems[index].workspace.id),
        ),
        itemCount: state.bookItems.length,
      ),
    );
  }
}
