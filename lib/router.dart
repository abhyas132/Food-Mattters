import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foods_matters/auth/screens/otp_screen.dart';
import 'package:foods_matters/provider_route/features/food_services/screens/post_food.dart';
import 'package:foods_matters/provider_route/features/user_services/screens/ngo_details_screen.dart';
import 'package:foods_matters/provider_route/features/user_services/screens/search_screen.dart';
import 'package:foods_matters/provider_route/features/user_services/screens/user_registration.dart';
import 'package:foods_matters/provider_route/widgets/bottom_bar.dart';
import 'package:foods_matters/screens/error_screen.dart';
import 'package:foods_matters/screens/home_screen.dart';

import 'auth/screens/otp_verification_screen.dart';
import './models/user_model.dart';

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

    case PostFood.routeName:
      return CupertinoPageRoute(
        builder: (ctx) => const PostFood(),
      );

    case RegistrationScreen.routeName:
      return CupertinoPageRoute(
        builder: (ctx) => const RegistrationScreen(),
      );

    case BottomBar.routeName:
      return CupertinoPageRoute(
        builder: (ctx) => const BottomBar(),
      );
    case SearchedResults.routeName:
      final query = settings.arguments as String;
      return CupertinoPageRoute(
        builder: (ctx) => SearchedResults(
          q: query,
        ),
      );
    case NgoDetails.routeName:
      final user = settings.arguments as User;
      return CupertinoPageRoute(
        builder: (ctx) => NgoDetails(user),
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
