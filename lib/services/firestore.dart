import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unnameddatingapp/statics/constants.dart';

class AppDatabase {
  static Firestore _firestore = Firestore.instance;

  static Firestore getFireStoreInstance() {
    return _firestore;
  }

  static Future createProfile(FirebaseUser user) async{
    if (user == null) return;
    Firestore store = AppDatabase.getFireStoreInstance();
    DocumentSnapshot documentSnapshot;
    try{
      documentSnapshot = await store.collection("users").document(user.uid).get();
    }
    on Exception catch (e){
      print("Something wrong with document retrieval");
      print(e);
    }
    if (documentSnapshot.exists) return;
    store.collection("users").document(user.uid).setData(<String,dynamic>{"created":FieldValue.serverTimestamp()});
    store
        .collection("users")
        .document(user.uid)
        .collection(PROFILE)
        .document(PERSONAL_PROFILE)
        .setData(<String, dynamic>{"created": FieldValue.serverTimestamp()});
    store
        .collection("users")
        .document(user.uid)
        .collection(PROFILE)
        .document(MUSIC_TASTE)
        .setData(<String, dynamic>{"created": FieldValue.serverTimestamp()});
    store
        .collection("users")
        .document(user.uid)
        .collection(PROFILE)
        .document(MOVIES)
        .setData(<String, dynamic>{"created": FieldValue.serverTimestamp()});
    store
        .collection("users")
        .document(user.uid)
        .collection(PROFILE)
        .document(TECH_LIFE)
        .setData(<String, dynamic>{"created": FieldValue.serverTimestamp()});
    store
        .collection("users")
        .document(user.uid)
        .collection(PROFILE)
        .document(EXTRAS)
        .setData(<String, dynamic>{"created": FieldValue.serverTimestamp()});
  }
}
