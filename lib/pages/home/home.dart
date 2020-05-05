import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Key key;

  Home({this.key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
