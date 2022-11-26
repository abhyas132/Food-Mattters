import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/auth/screens/otp_verification_screen.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
  ),
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

  Future<int> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    const uri = GlobalVariables.baseUrl;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(
        credential,
      );

      final res = await http.patch(
        Uri.parse(
          "${uri}api/v1/login",
        ),
        body: {
          "phoneNumber": auth.currentUser!.phoneNumber,
        },
      );
      print(res.statusCode);
      if (res.statusCode == 401) {
        return 401;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
      return res.statusCode;
    } on FirebaseAuthException catch (e) {
      ShowSnakBar(context: context, content: e.message!);
      return 404;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
