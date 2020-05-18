import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firestore.dart';
import '../../statics/constants.dart';

class ProfileUpdateController extends ChangeNotifier {
  Map<String, dynamic> personalInfoMap;
  Map<String, dynamic> musicTasteMap;
  Map<String, dynamic> movies;
  Map<String, dynamic> techLifeMap;
  Map<String, dynamic> extras;

  ProfileUpdateController() {
    this.personalInfoMap = <String, dynamic>{};
    this.musicTasteMap = <String, dynamic>{};
    this.movies = <String, dynamic>{};
    this.techLifeMap = <String, dynamic>{};
    this.extras = <String, dynamic>{};
  }

  void updateProfile(FirebaseUser user){
    Firestore store = AppDatabase.getFireStoreInstance();
    WriteBatch batch = store.batch();
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(PERSONAL_PROFILE), personalInfoMap);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(MUSIC_TASTE), musicTasteMap);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(MOVIES), movies);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(TECH_LIFE), techLifeMap);
    batch.updateData(store.collection("users").document(user.uid).collection(PROFILE).document(EXTRAS), extras);
    batch.commit().catchError((error){
      //TODO: Handle network errors;
    });
  }
}
