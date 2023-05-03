import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  final _auth = FirebaseAuth.instance;

  //can be print in console i guess
  Future<UserCredential> getAnonUserSingInResult() async {
    UserCredential result;
    try {
      result = await _auth.signInAnonymously();
      //AuthResult.user type=FireBaseUser
    } catch (e) {
      print(e + '...............................');
      result = null;
    }
    return result;
  }

//  Future<AuthResult> getPhoneVerificationResult() async{
//    AuthResult result;
//    try{
//      result = await _auth.ph
//    }catch(e){
//      print(e);
//      result = null;
//    }
//
//    return result;
//  }

  User getAnonUserData(UserCredential result) {
    User user;
    try {
      user = result.user;
    } catch (e) {
      user = null;
    }

    return user;
  }

  signinwgoogle() async {
    final GoogleSignInAccount gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final Credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(Credential);
  }

  Future<User> getCurrentFireBaseUser() async {
    var user = _auth.currentUser;
    return user;
  }

  Future<String> getCurrentFireBaseUserID() async {
    var currentUser = _auth.currentUser;
    String currentUserId = currentUser.uid;
    if (currentUserId == null) {
      return 'NoUserYet';
    } else {
      return currentUser.uid;
    }
  }

  Future<bool> isUserAuthenticated() async {
    var currentUser = _auth.currentUser;
    if (currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
