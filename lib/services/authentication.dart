import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static void signInAnonym() {
    _auth.signInAnonymously().then((value) {}, onError: (error) {
      print(error.code);
      return;
    });
  }

  static Stream<FirebaseUser> getUserStream() {
    return _auth.onAuthStateChanged;
  }
}
