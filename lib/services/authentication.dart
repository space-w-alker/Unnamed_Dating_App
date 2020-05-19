import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unnameddatingapp/services/firestore.dart';

class Authentication {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static void signInAnonym() {
    _auth.signInAnonymously().then((value) {}, onError: (error) {
      print(error.code);
      return;
    });
  }

  static Stream<FirebaseUser> getUserStream() {
    return _auth.onAuthStateChanged;
  }

  static Future linkWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

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
