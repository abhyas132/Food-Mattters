// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/auth/controller/auth_controller.dart';
import 'package:foods_matters/auth/screens/otp_screen.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/route/features/user_services/repository/user_services_repository.dart';
import 'package:foods_matters/route/features/user_services/screens/common/user_registration.dart';
import 'package:foods_matters/route/widgets/hostel/p_bottom_bar.dart';
import 'package:foods_matters/route/widgets/ngo/c_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/OTPVerificationScreen';
  final String verificationId;
  const OTPVerificationScreen({
    super.key,
    required this.verificationId,
  });

  @override
  ConsumerState<OTPVerificationScreen> createState() =>
      _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends ConsumerState<OTPVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();

  void verifyOTP(
    BuildContext context,
    String userOTP,
  ) async {
    final resStatus = await ref.read(authControllerProvider).verifyOTP(
          context,
          widget.verificationId,
          userOTP,
        );
    print(resStatus);
    if (resStatus == 200) {
      final user = await ref.watch(userRepositoryProvider).getUserData();
      if (user != null) {
        // ignore: use_build_context_synchronously
        if (user.userType == "Consumer") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            C_BottomBar.routeName,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            P_BottomBar.routeName,
            (route) => false,
          );
        }
      } else {
        print("null hoon main");
        Navigator.pushNamedAndRemoveUntil(
          context,
          OTPScreen.routeName,
          (route) => false,
        );
      }
    } else if (resStatus == 401) {
      print("chal bhai register ker le");
      Navigator.pushNamed(
        context,
        RegistrationScreen.routeName,
      );
    } else if (resStatus == 404) {
      print("null hoon main");
      Navigator.pushNamedAndRemoveUntil(
        context,
        OTPScreen.routeName,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'images/loginui.png',
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: LottieBuilder.asset(
                            'assets/l6.json',
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  )
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  keyboardType: TextInputType.phone,
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: textEditingController,
                  onCompleted: (val) {
                    if (val.length == 6) {
                      verifyOTP(
                        context,
                        val,
                      );
                    } else {
                      ShowSnakBar(
                        context: context,
                        content: 'please enter 6 digit otp code',
                      );
                    }
                    print(val);
                  },
                  onChanged: (val) {
                    print(val);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
