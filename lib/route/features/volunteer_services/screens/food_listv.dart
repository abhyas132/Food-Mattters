import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/route/features/user_services/screens/hostel/search_screen.dart';
import 'package:foods_matters/route/features/volunteer_services/controller/volunteer_controller.dart';
import 'package:foods_matters/route/features/volunteer_services/screens/delivery_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../widgets/volunteer/v_food_field.dart';

class VListOfFoodScreen extends ConsumerStatefulWidget {
  const VListOfFoodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VListOfFoodScreenState();
}

class _VListOfFoodScreenState extends ConsumerState<VListOfFoodScreen> {
  List<Food> foodList = [];
  List<String> foodIds = [];
  var sum = 0;
  final searchController = TextEditingController();
  Future<List<Food>> getFoodFeed(bool refresh) async {
    foodList = await ref.watch(foodRepostitoryProvider).getFoodFeedToConsumer();
    return foodList;
  }

  Future getu() async {
    setState(() {});
    return await getFoodFeed(true);
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

  void updateList(String foodId, int amount) {
    foodIds.add(foodId);
    sum += amount;
  }

  @override
  Widget build(BuildContext context) {
    final volunteerController = ref.watch(volunteerControllerProvider);
    final user = ref.watch(userDataProvider).user;
    var sum = 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          //backgroundColor: ,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Food Matters',
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(1),
              child: AnimSearchBar(
                animationDurationInMilli: 100,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                autoFocus: true,
                closeSearchOnSuffixTap: true,
                helpText: "Search...",
                rtl: false,
                width: MediaQuery.of(context).size.width * 0.8,
                textController: searchController,
                onSuffixTap: () {
                  Navigator.pushNamed(
                    context,
                    SearchedResults.routeName,
                    arguments: searchController.text.trim(),
                  );
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: GlobalVariables.selectedNavBarColor,
                ),
                suffixIcon: Icon(
                  Icons.arrow_back,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
      body: LoaderOverlay(
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 250),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GradientText(
                            '${greeting().toString()}, ${user.name}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            colors: const [
                              Colors.blue,
                              Colors.red,
                              Colors.teal,
                            ],
                          ),
                          Row(
                            children: [
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
                                "100+",
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: RefreshIndicator(
                        onRefresh: getu,
                        child: FutureBuilder(
                          future: getFoodFeed(true),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: VFoodField(
                                          food: snapshot.data![index],
                                          updateList: updateList,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                context.loaderOverlay.show();
                await volunteerController
                    .sendTargetPostRequest(foodIds, user.userId!)
                    .then((value) {
                  context.loaderOverlay.hide();
                  ShowSnakBar(context: context, content: 'Notification sent !');
                  Navigator.pushNamed(context, DeliveryScreen.routeName,
                      arguments: LatLng(user.latitude!, user.longitude!));
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.11,
                decoration: BoxDecoration(
                    color: Colors.teal.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: Center(
                    child: Text('CONFIRM',
                        style: GoogleFonts.poppins(fontSize: 16))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
