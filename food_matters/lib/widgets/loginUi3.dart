import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

Widget LoginUi3Widget(BuildContext context) {
  return Container(
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   'Food Matters',
        //   style: GoogleFonts.lato(
        //     fontSize: 32,
        //     fontWeight: FontWeight.bold,
        //     color: Color.fromARGB(255, 3, 63, 9),
        //   ),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: LottieBuilder.asset(
            'assets/l6.json',
          ),
        ),
        // Text(
        //   'Login / register',
        //   style: GoogleFonts.lato(
        //     fontSize: 32,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black54,
        //   ),
        // ),
      ],
    ),
  );
}
