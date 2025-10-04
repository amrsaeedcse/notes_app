import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth {
  final fireBaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn.instance;
  Future signInGoogle() async {
    await googleSignIn.initialize(
      serverClientId:
          "305272197162-kp60kodj97ckthcupd0pbj1406p9vj2h.apps.googleusercontent.com",
    );
    GoogleSignInAccount googleSignInAccount = await googleSignIn.authenticate();

    GoogleSignInAuthentication googleSignInAuthentication =
        googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
    );
    await fireBaseAuth.signInWithCredential(authCredential);
  }
}
