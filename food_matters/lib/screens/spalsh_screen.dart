import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_matters/screens/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Wrapper(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            opacity: 0.5,
            image: AssetImage('images/splash.png'),
          ),
        ),
        // child: Image.asset(
        //   'images/splash.png',
        //   fit: BoxFit.fill,
        // ),
      ),
    );
  }
}
