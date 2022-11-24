import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/auth/controller/auth_controller.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

class OTPScreen extends ConsumerStatefulWidget {
  static const String routeName = '/OTPScreen';
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
  }

  void sendPhoneNumber() async {
    String phoneNumber = phoneNumberController.text;
    phoneNumber = '+91$phoneNumber';
    phoneNumber = phoneNumber.trim();
    context.loaderOverlay.show();
    await ref.read(authControllerProvider).signInWithPhone(
          context,
          phoneNumber,
        );
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.565,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/loginui.png'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Food Matters',
                      style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 3, 63, 9),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: LottieBuilder.asset(
                        'assets/l5.json',
                      ),
                    ),
                    Text(
                      'Login / register',
                      style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Hello, nice to meet you!',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Let\'s get started with food matters',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '+91',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 45,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 22.0,
                              letterSpacing: 8,
                              color: Colors.black,
                            ),
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                              fillColor: Colors.black,
                              iconColor: Colors.black,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                              ),
                              hintText: "Phone",
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (phoneNumberController.text.trim().length == 10) {
                        sendPhoneNumber();
                      } else {
                        ShowSnakBar(
                          context: context,
                          content: 'please enter a valid phone number',
                        );
                      }
                      //Navigator.pushNamed(context, PostFood.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 154, 230, 156),
                      elevation: 2,
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'send otp',
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
