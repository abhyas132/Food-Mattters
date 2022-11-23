import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';
import 'package:foods_matters/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/widgets/consumer_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SearchedResults extends ConsumerStatefulWidget {
  static const routeName = "searched-results";
  String q;
  SearchedResults({super.key, required this.q});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchedResultsState();
}

class _SearchedResultsState extends ConsumerState<SearchedResults> {
  Future<List<User?>> searchResults(String q) async {
    List<User?> searchList = [];
    try {
      searchList = await ref.watch(userControllerProvider).searchedUsers(q);
    } catch (e) {
      ShowSnakBar(context: context, content: e.toString());
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).user;
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
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Searched results",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: FutureBuilder(
                  future: searchResults(widget.q),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            "No matched found",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Consumerwidget(
                              user: snapshot.data![index]!,
                              myLat: user.latitude!,
                              myLong: user.longitude!,
                            );
                          },
                        );
                      }
                    } else {
                      return Center(child: Lottie.asset("assets/search.json"));
                    }
                  }),
                ),
              ),
            ],
          )),
    );
  }
}
