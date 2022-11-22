import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalVariables {
  // COLORS
<<<<<<< HEAD
  static const baseUrl = 'http://10.20.15.96:3000/';
=======

  static const baseUrl = 'http://192.168.1.6:3000/';
>>>>>>> 27398d1d85e1e69d4b6701a11a7d40668a805023
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

}
