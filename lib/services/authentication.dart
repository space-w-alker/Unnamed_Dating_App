import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    await _auth
        .currentUser()
        .then((value) => value.linkWithCredential(credential));
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
