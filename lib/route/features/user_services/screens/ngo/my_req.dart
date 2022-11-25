import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/models/request_model.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/route/widgets/hostel/all_food_widget.dart';
import 'package:foods_matters/route/widgets/hostel/food_widget_to_me.dart';
import 'package:foods_matters/route/widgets/hostel/request_widget.dart';
import 'package:foods_matters/route/widgets/ngo/CrequestWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

class MyRequestScreen extends ConsumerStatefulWidget {
  const MyRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyRequestScreenState();
}

class _MyRequestScreenState extends ConsumerState<MyRequestScreen> {
  List<Request> allActiveFoodList = [];
  List<Request> allFoodList = [];
  Future<List<Request>> getAllMyActiveFoodReq() async {
    allActiveFoodList =
        await ref.watch(foodControllerProvider).getAllMyRequestSentAsConsumer();
    return allActiveFoodList;
  }

  Future<List<Request>> getAllMyFoodReq() async {
    allFoodList =
        await ref.watch(foodControllerProvider).getAllMyRequestSentAsConsumer();
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
              'Manage my Requests',
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
                    FontAwesomeIcons.userPen,
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
                                child: CRequestWidget(
                                  rqt: snapshot.data![index],
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
                      "There are no food request",
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
                                child: CRequestWidget(
                                  rqt: snapshot.data![index],
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
                      "There are no active food donation requests",
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
