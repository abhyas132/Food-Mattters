import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';
import 'package:foods_matters/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/features/user_services/repository/user_services_repository.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/widgets/consumer_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ListOfNgoScreen extends ConsumerStatefulWidget {
  const ListOfNgoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListOfNgoScreenState();
}

class _ListOfNgoScreenState extends ConsumerState<ListOfNgoScreen> {
  List<User?> userList = [];

  Future<List<User?>> getAllUser(bool refresh) async {
    userList = await ref.watch(userControllerProvider).getAllUsers(
          ref.read(userDataProvider).user.userType!,
          refresh,
        );

    return userList;
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
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
              child: Row(
                children: [
                  GradientText(
                    'Good ${greeting().toString()}, ${user.name}',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    colors: [
                      Colors.blue,
                      Colors.red,
                      Colors.teal,
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder(
                future: getAllUser(true),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          // print()
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
        onPressed: () {},
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
