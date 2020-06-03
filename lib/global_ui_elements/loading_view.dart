import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import '../statics/constants.dart';

class WidgetLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitPulse(
        size: 100,
        duration: Duration(milliseconds: 1000),
        color: Colors.white,
      ),
    );
  }
}

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(canvasColor: Colors.transparent),
      darkTheme: DARK_THEME,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: Center(
            child: SpinKitWave(size: 30,
              duration: Duration(milliseconds: 1000),
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
