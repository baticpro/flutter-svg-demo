import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = SimpleStateManager.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('tte'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => t.book('001'), child: Text('press 222')),
          for (final b in t.bookItems) Text('--====='),
        ],
      ),
    );
  }
}
