import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_matters/providers/auth_service.dart';
import 'package:food_matters/screens/home_screen.dart';
import 'package:food_matters/screens/onBoardingScreen.dart';
import 'package:food_matters/screens/otp_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService authenticationService =
        Provider.of<AuthenticationService>(context);
    return StreamBuilder(
        stream: authenticationService.user,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user != null ? HomeScreen() : OnBoardingPage();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
