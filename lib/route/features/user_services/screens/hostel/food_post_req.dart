import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/request_model.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/route/widgets/hostel/request_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

class FoodPostReq extends ConsumerStatefulWidget {
  String foodPostId;
  FoodPostReq({super.key, required this.foodPostId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FoodPostReqState();
}

class _FoodPostReqState extends ConsumerState<FoodPostReq> {
  List<Request> rqts = [];

  Future<List<Request>> getFoodPostReq(String foodPostId) async {
    rqts =
        await ref.watch(foodControllerProvider).getAllMyFoodPostReq(foodPostId);
    return rqts;
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            "Active requests",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: FutureBuilder(
          future: getFoodPostReq(widget.foodPostId),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return RequestWidget(rqt: snapshot.data![index]);
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LottieBuilder.asset("assets/waiting.json"),
              );
            } else {
              return Center(
                child: Text(
                  "You don't have any requests",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
