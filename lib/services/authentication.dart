import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unnameddatingapp/services/firestore.dart';
import '../statics/constants.dart';

class Authentication {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static Future signInAnonym() async{
    await _auth.signInAnonymously();
  }

  static FirebaseAuth getInstance(){
    return _auth;
  }

  static Stream<FirebaseUser> getUserStream() {
    return _auth.onAuthStateChanged;
  }

  static Future linkWithGoogle({Map<String,dynamic> mapInfo}) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    if(mapInfo != null){
      mapInfo[IMAGE_URL] = googleSignInAccount.photoUrl;
      mapInfo[USER_NAME_FIELD] = googleSignInAccount.displayName;
    }

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser currUser = await _auth.currentUser();
    try {
      await currUser.linkWithCredential(credential);
    } on PlatformException catch (error) {
      if (error.code == "ERROR_CREDENTIAL_ALREADY_IN_USE") {
        await deleteUser(currUser);
        await _auth.signInWithCredential(credential);
      } else {
        rethrow;
      }
    }
  }

  static Future signOutGoogle() async {
    await googleSignIn.signOut();
  }

  static Future deleteUser(FirebaseUser currUser) async {
    await AppDatabase.getFireStoreInstance()
        .collection("users")
        .document(currUser.uid)
        .delete();
    await currUser.delete();
  }
}
