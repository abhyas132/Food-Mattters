import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/route/features/food_services/screens/post_food.dart';
import 'package:foods_matters/route/features/user_services/controller/user_controller.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/route/features/user_services/screens/hostel/search_screen.dart';
import 'package:foods_matters/route/widgets/hostel/consumer_widget.dart';
import 'package:foods_matters/route/widgets/ngo/food_feed_widget.dart';
import 'package:foods_matters/route/widgets/hostel/food_widget_to_me.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void addIdToList(String foodId , int foodQuantity) {
    if (!foodIds.contains(foodId)) {
      foodIds.add(foodId);
      sum += foodQuantity;
    }
    log(foodIds.length.toString());
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

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                                        updateList: addIdToList,
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
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Center(child: Text('${sum}')),
          ),
        ],
      ),
    );
  }
}
