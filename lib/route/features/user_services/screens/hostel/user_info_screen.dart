// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
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
  final FirebaseDatabase reference = FirebaseDatabase.instance;
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final scoreController = TextEditingController();
  List<Map<String, String>> list = [];

  Widget listItem(Map player) {
    print(player);
    return Text("hello");
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
    return Container(
      decoration: BoxDecoration(
        color: GlobalVariables.greyBackgroundCOlor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Icon(Icons.arrow_back_ios),
          actions: [
            Icon(
              Icons.grid_view,
              color: Colors.white,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: GlobalVariables.secondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "users around me",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const LeaderBoardWidget(),
                //  ListView.builder(itemBuilder: ())
                ElevatedButton(
                  onPressed: () {},
                  child: Text("press"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
