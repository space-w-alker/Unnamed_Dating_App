import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{
  bool _isLoading = false;

  bool get isLoading{
    return _isLoading;
  }
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
}