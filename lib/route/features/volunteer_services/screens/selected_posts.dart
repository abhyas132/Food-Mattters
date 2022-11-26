import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/route/features/volunteer_services/controller/volunteer_controller.dart';
import 'package:logger/logger.dart';

import '../../../../common/global_constant.dart';
import '../../../../models/food_model.dart';
import '../../../widgets/volunteer/posts.dart';
import '../../../widgets/volunteer/v_food_field.dart';

class SelectedPostsScreen extends ConsumerStatefulWidget {
  const SelectedPostsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectedPostsScreenState();
}

class _SelectedPostsScreenState extends ConsumerState<SelectedPostsScreen> {
  Future<List<Food>> getFoodFeed() async {
    List<Food> foodList = await ref
        .watch(volunteerControllerProvider)
        .getAllSelectedPosts(ref.watch(userDataProvider).user.userId!);
    return foodList;
  }

  Future<List<Food>> refresh() async {
    setState(() {});
    return await getFoodFeed();
  }

  @override
  Widget build(BuildContext context) {
    final volunteerProvider = ref.watch(volunteerControllerProvider);
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Deliveries'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: getFoodFeed(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final mapData = snapshot.data; // list of food objects
                  Logger().d(mapData);
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: FadeInAnimation(child: Posts(mapData![index])),
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
    );
  }
}
