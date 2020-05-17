import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'statics/route_generator.dart';
import 'services/authentication.dart';

void main() {
  runApp(StreamProvider(
    create: (BuildContext context) {
      return Authentication.getUserStream();
    },
    builder: (context, child) {
      return MyApp();
    },
    child: Text(""),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          canvasColor: Colors.white,
          primaryColorDark: Colors.black,
          primaryColor: Colors.grey[800],
          primaryColorLight: Colors.grey[400],
          textSelectionColor: Colors.grey,
          textSelectionHandleColor: Colors.black,
          cursorColor: Colors.black,
          textTheme: TextTheme(
              headline1: TextStyle(color: Colors.white),
              headline5: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 4,
                  fontSize: 16),
              headline6: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0,
                  fontSize: 12),
              subtitle2: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 3,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
                  button: TextStyle(color: Colors.white, letterSpacing: 2))),
      darkTheme: ThemeData(
          canvasColor: Colors.black,
          primaryColor: Colors.grey[700],
          primaryColorLight: Colors.grey),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.routegenerator,
    );
  }
}
