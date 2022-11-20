import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/features/user_services/screens/user_registration.dart';
import 'package:foods_matters/screens/home_screen.dart';
import 'package:foods_matters/features/auth/screens/otp_verification_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(auth: FirebaseAuth.instance),
);

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({
    required this.auth,
  });

  Future signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OTPVerificationScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      ShowSnakBar(
        context: context,
        content: e.message!,
      );
    }
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
      await auth.signInWithCredential(
        credential,
      );
      // ignore: use_build_context_synchronously


      Navigator.pushNamedAndRemoveUntil(
        context,
        RegistrationScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ShowSnakBar(context: context, content: e.message!);
    }
  }
}
