import 'package:flutter/material.dart';

class FlashcardsPage extends StatelessWidget {
  final Key key;

  FlashcardsPage({this.key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Flashcards Page"),
      ),
    );
  }
}