import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/provider_route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/provider_route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/provider_route/widgets/all_food_widget.dart';
import 'package:foods_matters/provider_route/widgets/food_widget_to_me.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

class FoodRequestScreen extends ConsumerStatefulWidget {
  const FoodRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FoodRequestScreenState();
}

class _FoodRequestScreenState extends ConsumerState<FoodRequestScreen> {
  List<Food> allActiveFoodList = [];
  List<Food> allFoodList = [];
  Future<List<Food>> getAllMyActiveFoodReq() async {
    allActiveFoodList =
        await ref.watch(foodControllerProvider).getMyActiveReq();
    return allActiveFoodList;
  }

  Future<List<Food>> getAllMyFoodReq() async {
    allFoodList = await ref.watch(foodControllerProvider).getAllMyFoodReq();
    return allFoodList;
  }

  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Manage my Food Donation',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.bowlFood,
                  ),
                ),
                Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.clockRotateLeft,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder(
                future: getAllMyActiveFoodReq(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: FlipAnimation(
                              // verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: foodwidget(
                                  food: snapshot.data![index],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: LottieBuilder.asset("assets/waiting.json"),
                    );
                  } else {
                    return Center(
                        child: Text(
                      "There is no any active food donation request",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ));
                  }
                },
              ),
              FutureBuilder(
                future: getAllMyFoodReq(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: FlipAnimation(
                              //verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: allfoodwidget(
                                  food: snapshot.data![index],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: LottieBuilder.asset("assets/waiting.json"),
                    );
                  } else {
                    return Center(
                        child: Text(
                      "There is no any active food donation request",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
