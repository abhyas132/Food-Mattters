import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/provider_route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/provider_route/features/food_services/repository/foodpost_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodRequestScreen extends ConsumerStatefulWidget {
  const FoodRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FoodRequestScreenState();
}

class _FoodRequestScreenState extends ConsumerState<FoodRequestScreen> {
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.watch(foodControllerProvider).getMyActiveReq();
                },
                child: const Text("abc"),
              ),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
