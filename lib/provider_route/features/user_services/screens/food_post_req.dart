import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/provider_route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/provider_route/features/food_services/repository/foodpost_repository.dart';

class FoodPostReq extends ConsumerStatefulWidget {
  String foodPostId;
  FoodPostReq({super.key, required this.foodPostId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FoodPostReqState();
}

class _FoodPostReqState extends ConsumerState<FoodPostReq> {
  void getFoodPostReq(String foodPostId) async {
    final res =
        ref.watch(foodControllerProvider).getAllMyFoodPostReq(foodPostId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          ref
              .watch(foodRepostitoryProvider)
              .getAllMyFoodPostReq(widget.foodPostId);
        },
        child: Text("dcjnc"),
      )),
    );
  }
}
