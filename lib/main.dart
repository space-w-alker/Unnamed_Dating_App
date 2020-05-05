
import 'package:flutter/material.dart';
import 'statics/route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.routegenerator,
    );
  }
}

