import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firestore.dart';
import '../../statics/constants.dart';

class ProfileUpdateController extends ChangeNotifier {
  Map<String, dynamic> personal_info;
  Map<String, dynamic> music_taste;
  Map<String, dynamic> movies;
  Map<String, dynamic> tech_life;
  Map<String, dynamic> extras;

  ProfileUpdateController() {
    this.personal_info = <String, dynamic>{};
    this.music_taste = <String, dynamic>{};
    this.movies = <String, dynamic>{};
    this.tech_life = <String, dynamic>{};
    this.extras = <String, dynamic>{};
  }

  void updateProfile(FirebaseUser user){
    Firestore store = AppDatabase.getFireStoreInstance();
    WriteBatch batch = store.batch();
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(PERSONAL_PROFILE), personal_info);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(MUSIC_TASTE), music_taste);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(MOVIES), movies);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(TECH_LIFE), tech_life);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(EXTRAS), extras);
    batch.commit();
  }
}
