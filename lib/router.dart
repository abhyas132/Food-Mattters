import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foods_matters/screens/error_screen.dart';
import 'package:foods_matters/screens/home_screen.dart';
import 'package:foods_matters/screens/otp_screen.dart';
import 'package:foods_matters/screens/otp_verification_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OTPScreen.routeName:
      return CupertinoPageRoute(
        builder: (ctx) => const OTPScreen(),
      );
    case OTPVerificationScreen.routeName:
      final verificationId = settings.arguments as String;
      return CupertinoPageRoute(
        builder: (ctx) => OTPVerificationScreen(
          verificationId: verificationId,
        ),
      );

    case HomeScreen.routeName:
      return CupertinoPageRoute(
        builder: (ctx) => const HomeScreen(),
      );

    default:
      return CupertinoPageRoute(
        builder: (ctx) => const Scaffold(
          body: ErrorScreen(
            error: 'This page doesn\'t exist',
          ),
        ),
      );
  }
}
