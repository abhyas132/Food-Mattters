import 'dart:convert';
import 'dart:ffi';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/provider_route/features/food_services/controller/foodpost_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toggle_switch/toggle_switch.dart';

class foodFeedwidget extends ConsumerStatefulWidget {
  Food food;
  double? myLat;
  double? myLong;
  foodFeedwidget({
    super.key,
    required this.food,
    this.myLat,
    this.myLong,
  });

  @override
  ConsumerState<foodFeedwidget> createState() => _foodFeedwidgetState();
}

class _foodFeedwidgetState extends ConsumerState<foodFeedwidget> {
  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      //scale: 10,
      width: 200,
      // height: 200,

      fit: BoxFit.fitWidth,
    );
  }

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 15.0,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    //Image.memory(base64Decode(base64String));

    //print(widget.user.latitude);
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Chip(
                      label: widget.food.requests!.length > 5
                          ? AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'Many requests',
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                ),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            )
                          : AnimatedTextKit(
                              pause: const Duration(
                                milliseconds: 10,
                              ),
                              repeatForever: true,
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'apply fast',
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                ),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: 100,
                      child:
                          widget.food.photo == null || widget.food.photo == ""
                              ? Image.asset("images/no_image.png")
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: imageFromBase64String(
                                    widget.food.photo,
                                  ),
                                ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "food type :",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "  ${widget.food.foodType}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: widget.food.foodType == "Veg"
                                    ? Colors.green
                                    : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'food life :',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '   x ${widget.food.foodLife}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'food Qty :',
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '  x ${widget.food.foodQuantity}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Item List : ',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            DropdownButton<dynamic>(
                              alignment: Alignment.topCenter,
                              iconSize: 0,
                              elevation: 0,
                              hint: Text("items",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  )),
                              items: widget.food.food.map((dynamic value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Badge(
                              shape: BadgeShape.circle,
                              badgeColor: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(2),
                              badgeContent: Text(
                                widget.food.requests!.length.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.usersRays,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.24,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Colors.cyan.withOpacity(0.8),
                                    Colors.indigo.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: Colors.deepPurple.shade300,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final res = await ref
                                      .watch(foodControllerProvider)
                                      .reqForFood(
                                        widget.food.id!,
                                      );

                                  if (res == 200) {
                                    ShowSnakBar(
                                      context: context,
                                      content: "your request was sent",
                                    );
                                  } else if (res == 403) {
                                    ShowSnakBar(
                                      context: context,
                                      content:
                                          "you already have sent request for this",
                                    );
                                  } else {
                                    ShowSnakBar(
                                      context: context,
                                      content: "error occurred",
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Request",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
