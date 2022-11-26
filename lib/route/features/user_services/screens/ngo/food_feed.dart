import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/route/features/user_services/screens/hostel/search_screen.dart';
import 'package:foods_matters/route/widgets/ngo/food_feed_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ListOfFoodScreen extends ConsumerStatefulWidget {
  const ListOfFoodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListOfFoodScreenState();
}

class _ListOfFoodScreenState extends ConsumerState<ListOfFoodScreen> {
  List<Food> foodList = [];
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

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    final user = ref.watch(userDataProvider).user;
    logger.log(Level.verbose, 'ENTERED');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
      body: SingleChildScrollView(
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
                                child: foodFeedwidget(
                                  food: snapshot.data![index],
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
    );
  }
}
