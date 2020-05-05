import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final Key key;

  ChatList({this.key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Chat List Page"),
      ),
    );
  }
}