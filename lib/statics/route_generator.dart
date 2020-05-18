import 'package:flutter/material.dart';
import '../routes/landing/landing.dart';


class RouteGenerator{
  static Route<dynamic> routegenerator(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) {
          return LandingRoute();
        });
        break;
      case "/profile_display":
        return MaterialPageRoute(builder: (BuildContext context){
          return null;
        });
        break;
      default:
        return null;
    }
  }
}