import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final bool loading;

  const ScreenScaffold(
      {Key? key,
      required this.title,
      required this.child,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(children: [
        child,
        if (loading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ]),
    );
  }
}
