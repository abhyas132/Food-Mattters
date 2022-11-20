import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';
import 'package:foods_matters/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/features/user_services/repository/user_services_repository.dart';
import 'package:foods_matters/features/food_services/screens/post_food.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/widgets/consumer_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/screens/otp_verification_screen.dart';

class ListOfNgoScreen extends ConsumerStatefulWidget {
  const ListOfNgoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListOfNgoScreenState();
}

class _ListOfNgoScreenState extends ConsumerState<ListOfNgoScreen> {
  List<User?> userList = [];

  Future<List<User?>> getAllUser() async {
    userList = await ref.watch(userControllerProvider).getAllUsers(
          ref.read(userDataProvider).user.userType!,
        );
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Hello, ${user.name}',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder(
                future: getAllUser(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Consumerwidget(
                            user: snapshot.data![index]!,
                            myLat: user.latitude!,
                            myLong: user.longitude!,
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            PostFood.routeName,
          );
        },
        backgroundColor: GlobalVariables.selectedNavBarColor,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              'share',
            ),
          ),
        ),
      ),
    );
  }
}
