import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_expance/common_widget/loder_widget.dart';
import 'package:money_expance/firebase/databs.dart';
import 'package:money_expance/module/authentication/ui/log_in_screen.dart';
import 'package:money_expance/module/tabs/home_screen.dart';
import 'package:money_expance/utilies/constant.dart';

class AuthenticationHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      loder();
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.back();
      return null;
    } on FirebaseAuthException catch (e) {
      Get.back();
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      loder();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.back();
      return true;
    } on FirebaseAuthException catch (e) {
      Get.back();
      return e.message;
    }
  }

  Future forgetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
    Get.offAll(const SignInScreen());
  }

  static Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      loder();
      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        user = userCredential.user;
        if (user != null &&
            userCredential.additionalUserInfo?.isNewUser == true) {
          FirebaseDatabase().setData(
              name: user.displayName,
              email: user.email,
              type: 'Google Sign in',
              uId: user.uid,
              photoUrl: user.photoURL);
        }
        Get.back();
        Get.offAll(const HomeScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(
              msg: e.code,
              backgroundColor: AppColors.violet100,
              textColor: AppColors.white);
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return null;
  }
}
