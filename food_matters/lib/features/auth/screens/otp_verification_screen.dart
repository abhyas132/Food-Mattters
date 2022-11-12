import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_matters/features/auth/controller/auth_controller.dart';
import 'package:food_matters/widgets/loginUi3.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  String? verificationId;
  OtpVerificationScreen({super.key, required verificationId});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  void verifyOTP(BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, widget.verificationId!, userOTP);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                LoginUi3Widget(context),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: MediaQuery.of(context).size.width * 0.06,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Phone verification',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Enter your OTP code below',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Pinput(
                length: 6,
                onCompleted: (pin) {
                  verifyOTP(context, pin);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: )
                },
                child: Text(
                  'resend otp',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 151, 222, 143)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
