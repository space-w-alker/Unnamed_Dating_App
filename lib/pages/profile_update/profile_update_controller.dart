import 'package:flutter/material.dart';

class ProfileUpdateController extends ChangeNotifier{
  Map<String, dynamic> personal_info;
  Map<String, dynamic> music_taste;
  Map<String, dynamic> movies;
  Map<String, dynamic> tech_life;
  Map<String, dynamic> extras;

  ProfileUpdateController(){
    this.personal_info = <String, dynamic>{};
    this.music_taste = <String, dynamic>{};
    this.movies = <String, dynamic>{};
    this.tech_life = <String, dynamic>{};
    this.extras = <String, dynamic>{};
  }
}