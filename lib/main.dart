import 'package:flutter/material.dart';

import 'UI/home_page.dart';

String title  = "XO";

void main() {
  runApp(TicTacToe());
}

class TicTacToe extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  title,
      theme:  ThemeData(
        primarySwatch:  Colors.amber,
      ),
      home: HomePage(title: title),

    );
  }
}
