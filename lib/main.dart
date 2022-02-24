import 'package:flutter/material.dart';
import 'package:testing_app_book_svg_office/navigation/bottom_tab_navigation.dart';
import 'package:testing_app_book_svg_office/repositories/dummy_api_repository.dart';
import 'package:testing_app_book_svg_office/state/simple_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SimpleStateManager(
      data: SimpleStateManagerData(DummyRepository()),
      child: MaterialApp(
        title: 'Key Svg Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black87,
            )),
        home: const BottomTabNavigation(),
      ),
    );
  }
}
