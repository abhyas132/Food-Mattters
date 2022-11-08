import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_matters/screens/otp_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'providers/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  final AuthenticationService _authenticationService = AuthenticationService();
  final Logger _logger = Logger();
  MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
          stream: _authenticationService.user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final User? user = snapshot.data as User?;
              _logger.d(user == null ? 'User not logged in' : 'User logged in');
              // if (user == null) {
              //   return OtpScreen();
              // } else {
              //check whether data is present in db :
              // if present then navigate to home screen
              //if not then send to register screen
              // }
              return OtpScreen();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
