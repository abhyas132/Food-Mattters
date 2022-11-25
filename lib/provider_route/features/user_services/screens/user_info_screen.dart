// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/auth/controller/auth_controller.dart';
import 'package:foods_matters/auth/screens/otp_screen.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/provider_route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/provider_route/features/user_services/screens/update_location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  var connections = 3;
  var listOfConnections = [
    "Spandan NGO",
    "Meera NGO",
    "Upchild foundation",
    "Shubh foundation",
    "KarBhalaHoBhala NGO",
    "KuchBhi NGO"
  ];

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final authProvidder = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout ?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('No')),
                      TextButton(
                        onPressed: () async {
                          await authProvidder.authRepository.logout();
                          final prefs = await SharedPreferences.getInstance();
                          prefs.remove('x-auth-token');
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            OTPScreen.routeName,
                            (route) => false,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text("Yes"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/splash.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    "Hello ${userData.user.name}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[300],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  SizedBox(
                    height: 30,
                    child: GestureDetector(
                        onTap: () => {
                              Navigator.pushNamed(
                                  context, UpdateLocationScreen.routeName,
                                  arguments: LatLng(userData.user.latitude!,
                                      userData.user.longitude!)),
                            },
                        child: Container(
                          // width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(239, 33, 149, 243),
                              style: BorderStyle.solid,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                blurRadius: 2.0,
                                spreadRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Center(
                              child: Text(
                            "Update Location",
                            style: GoogleFonts.montserrat(
                              color: Colors.blue.shade300,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          )),
                        )),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "History",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "You have made ${connections} connections in total",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                          ),
                        ),
                        Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            padding: const EdgeInsets.all(1),
                            height: 100,
                            width: double.infinity,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Card(
                                color: Colors.lightBlue.shade600,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 5,
                                  ),
                                  child: Text(listOfConnections[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                                ),
                              ),
                              itemCount:
                                  4, //we will only show first 3-4 connections here , on click of the "Show history" we can show more on next screen
                            )),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(children: const <Widget>[
                        Icon(Icons.help_outline_rounded),
                        SizedBox(width: 6),
                        Text('Help and FAQs')
                      ]),
                      Row(children: const <Widget>[
                        Icon(Icons.settings),
                        SizedBox(width: 6),
                        Text('Settings')
                      ]),
                      Row(children: const <Widget>[
                        Icon(Icons.bar_chart),
                        SizedBox(width: 6),
                        Text('Show donation graph')
                      ])
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
