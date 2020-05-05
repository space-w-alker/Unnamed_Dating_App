import 'package:flutter/material.dart';

class MatchMaker extends StatelessWidget {
  final Key key;

  MatchMaker({this.key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Matchmaker View"),
      ),
    );
  }
}