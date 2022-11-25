import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PostFood extends ConsumerStatefulWidget {
  static const String routeName = '/post-food';
  const PostFood({super.key});
  static TextStyle txtStyle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  @override
  ConsumerState<PostFood> createState() => _PostFoodState();
}

class _PostFoodState extends ConsumerState<PostFood> {
  FirebaseAuth? auth;
  int _quantityValue = 25;
  int _consumptionHours = 3;
  List<String> _addedItemList = [];
  String foodType = "Veg";
  final _foodItemController = TextEditingController();

  double? _distanceToField;
  TextfieldTagsController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  void addFoodPost({
    required String pushedBy,
    required bool isAvailable,
    required List<String> food,
    required num foodQuantity,
    required String foodType,
    required num foodLife,
  }) async {
    context.loaderOverlay.show();
    final res = await ref.watch(foodControllerProvider).addFoodPost(
          pushedBy: pushedBy,
          isAvailable: isAvailable,
          food: food,
          foodQuantity: foodQuantity,
          foodType: foodType,
          foodLife: foodLife,
        );
    context.loaderOverlay.hide();
    print(res);
    if (res == 200) {
      ShowSnakBar(context: context, content: "your food donation was added");
    } else {
      ShowSnakBar(context: context, content: "some error occured, try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Text(
          "Share Food",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      elevation: 10,
                      child: GestureDetector(
                        onTap: () {
                          ref.watch(foodControllerProvider).selectImage(true);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                          radius: 32,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Meal type",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  ToggleSwitch(
                    customTextStyles: [
                      GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColors: const [
                      [Color.fromARGB(255, 109, 239, 97)],
                      [Color.fromARGB(255, 236, 87, 87)]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: const ['Veg', 'Non-veg'],
                    radiusStyle: true,
                    onToggle: (index) {
                      if (index == 0) {
                        foodType = "Veg";
                      } else {
                        foodType = "Non-veg";
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Food Quantity : (Person)',
                style: PostFood.txtStyle,
              ),
              const SizedBox(height: 10),
              Slider(
                value: _quantityValue.toDouble(),
                min: 10.0,
                max: 100.0,
                divisions: 10,
                activeColor: Colors.green,
                inactiveColor: Colors.orange,
                label: _quantityValue.toString(),
                onChanged: (double newValue) {
                  setState(() {
                    _quantityValue = newValue.round();
                  });
                },
              ),
              const SizedBox(height: 10),
              Text(
                'To be consumed within :(hrs)',
                style: PostFood.txtStyle,
              ),
              const SizedBox(height: 15),
              Slider(
                value: _consumptionHours.toDouble(),
                min: 1.0,
                max: 10.0,
                divisions: 10,
                activeColor: Colors.green,
                inactiveColor: Colors.orange,
                label: _consumptionHours.toString(),
                onChanged: (double newValue) {
                  setState(() {
                    _consumptionHours = newValue.round();
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFieldTags(
                textfieldTagsController: _controller,
                initialTags: const [],
                textSeparators: const [' ', ','],
                letterCase: LetterCase.normal,
                validator: (String tag) {
                  if (tag == 'php') {
                    return 'No, please just no';
                  } else if (_controller!.getTags!.contains(tag)) {
                    return 'you already entered that';
                  }
                  return null;
                },
                inputfieldBuilder:
                    (context, tec, fn, error, onChanged, onSubmitted) {
                  return ((context, sc, tags, onTagDelete) {
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: TextField(
                        controller: tec,
                        focusNode: fn,
                        decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 74, 137, 92),
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 74, 137, 92),
                              width: 3.0,
                            ),
                          ),
                          helperText:
                              'you can enter different food item right above',
                          helperStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 137, 92),
                          ),
                          hintText:
                              _controller!.hasTags ? '' : "Enter foods...",
                          errorText: error,
                          prefixIconConstraints: BoxConstraints(
                              maxWidth: _distanceToField! * 0.74),
                          prefixIcon: tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: sc,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              tag,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              print(tags);
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: onChanged,
                        onSubmitted: (tag) {
                          if (tag.isNotEmpty) {
                            tags.add(tag);
                          }
                          tec.clear();
                          print(tags);
                          _addedItemList = tags;
                        },
                      ),
                    );
                  });
                },
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () => {
                              //make hhtp post request
                              // print(ref.watch(userDataProvider).user.userId),
                              addFoodPost(
                                pushedBy:
                                    ref.watch(userDataProvider).user.userId!,
                                isAvailable: true,
                                food: _addedItemList,
                                foodQuantity: _quantityValue,
                                foodType: foodType,
                                foodLife: _consumptionHours,
                              )
                            },
                        child: Text(
                          'POST',
                          style: PostFood.txtStyle,
                        )),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
