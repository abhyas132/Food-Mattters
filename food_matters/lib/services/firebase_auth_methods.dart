// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_matters/features/auth/screens/otp_verification_screen.dart';
import 'package:food_matters/utils/showSnackBar.dart';
import 'package:provider/provider.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> phonSignIN(BuildContext context, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (error) {
        showSnackBar(context, error.message!);
      },
      codeSent: ((String verificationId, int? resendCode) async {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => OtpVerificationScreen(
              verificationId: verificationId,
            ),
          ),
        );
      }),
      codeAutoRetrievalTimeout: ((verificationId) {}),
    );
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await _auth.signInWithCredential(credential);
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   UserInfoScreen.routeName,
      //   (route) => false,
      // );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
