// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/models/leader_board_model.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/route/features/user_services/repository/user_services_repository.dart';
import 'package:foods_matters/route/features/user_services/screens/common/update_location.dart';
import 'package:foods_matters/route/widgets/board_widget.dart';
import 'package:foods_matters/route/widgets/leaderboard_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../auth/controller/auth_controller.dart';
import '../../../../../auth/screens/otp_screen.dart';
import '../../../../../common/global_constant.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  // final FirebaseDatabase reference = FirebaseDatabase.instance;
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final scoreController = TextEditingController();
  List<Map<String, String>> list = [];

  Widget listItem(Map player) {
    print(player);
    return Text("hello");
  }

  Future<List<LeaderBoardModel>> getLeaderBoard() async {
    List<LeaderBoardModel> leaderBoard = [];
    leaderBoard = await ref.watch(userRepositoryProvider).getAllOnLeaderBoard();
    return leaderBoard;
  }

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
        title: Text(
          "My profile",
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/splash.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello, ${userData.user.name}",
                    style: TextStyle(
                      fontSize: 18,
                      color: GlobalVariables.selectedNavBarColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      color: Colors.yellow.withOpacity(0.3),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        "images/coin3.png",
                        width: 50,
                        height: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userData.points,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, UpdateLocationScreen.routeName,
                        arguments: LatLng(
                            userData.user.latitude!, userData.user.longitude!)),
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      // width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                GlobalVariables.secondaryColor.withOpacity(0.2),
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
                          color: GlobalVariables.selectedNavBarColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: GlobalVariables.secondaryColor.withOpacity(0.7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Leader Board",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const LeaderBoardWidget(),
              //  ListView.builder(itemBuilder: ())
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: FutureBuilder(
                  future: getLeaderBoard(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Board(
                              lm: snapshot.data![i],
                              i: i,
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: Text(
                        "Searching",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      ));
                    }
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
