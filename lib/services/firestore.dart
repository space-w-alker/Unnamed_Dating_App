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
    WriteBatch batch = store.batch();
    DocumentReference uiDocRef = store.collection("users").document(user.uid);
    DocumentReference personalProfileRef = store.collection("users").document(user.uid).collection(PROFILE).document(PERSONAL_PROFILE);
    DocumentReference musicTasteRef = store.collection("users").document(user.uid).collection(PROFILE).document(MUSIC_TASTE);
    DocumentReference moviesRef = store.collection("users").document(user.uid).collection(PROFILE).document(MOVIES);
    DocumentReference techLifeRef = store.collection("users").document(user.uid).collection(PROFILE).document(TECH_LIFE);
    DocumentReference extrasRef = store.collection("users").document(user.uid).collection(PROFILE).document(EXTRAS);

    batch.setData(uiDocRef, <String,dynamic>{"created":FieldValue.serverTimestamp()});
    batch.setData(personalProfileRef, <String,dynamic>{"created":FieldValue.serverTimestamp()});
    batch.setData(musicTasteRef, <String,dynamic>{"created":FieldValue.serverTimestamp()});
    batch.setData(moviesRef, <String,dynamic>{"created":FieldValue.serverTimestamp()});
    batch.setData(techLifeRef, <String,dynamic>{"created":FieldValue.serverTimestamp()});
    batch.setData(extrasRef, <String,dynamic>{"created":FieldValue.serverTimestamp()});
    batch.commit();
  }
}
