import 'dart:convert';
import 'dart:ffi';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/route/features/user_services/screens/hostel/food_post_req.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toggle_switch/toggle_switch.dart';

class foodwidget extends ConsumerStatefulWidget {
  Food food;
  double? myLat;
  double? myLong;
  foodwidget({
    super.key,
    required this.food,
    this.myLat,
    this.myLong,
  });

  @override
  ConsumerState<foodwidget> createState() => _foodwidgetState();
}

class _foodwidgetState extends ConsumerState<foodwidget> {
  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      //scale: 10,
      width: 200,
      // height: 200,

      fit: BoxFit.fitWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    //Image.memory(base64Decode(base64String));

    //print(widget.user.latitude);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoodPostReq(
                    foodPostId: widget.food.id!,
                  )),
        );
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            ToggleSwitch(
              minWidth: 100.0,
              minHeight: 50.0,
              initialLabelIndex: widget.food.isAvailable ? 1 : 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: const ["not-available", "available"],
              iconSize: 30.0,
              activeBgColors: const [
                [
                  Colors.black45,
                  Colors.red,
                ],
                [
                  Colors.green,
                  Color.fromARGB(255, 134, 228, 137),
                ]
              ],
              animate:
                  true, // with just animate set to true, default curve = Curves.easeIn
              curve: Curves
                  .bounceInOut, // animate must be set to true when using custom curve
              onToggle: (index) async {
                print('switched to: $index');
                context.loaderOverlay.show();
                if (index == 0) {
                  final res = await ref
                      .watch(foodControllerProvider)
                      .toggleFoodPostAvailablity(
                        "false",
                        widget.food.id!,
                      );
                  if (res == 200) {
                    ShowSnakBar(
                        context: context,
                        content: "Notification was unavailable succesfully");
                  } else {
                    ShowSnakBar(
                      context: context,
                      content: "something wrong happened",
                    );
                  }
                } else {
                  final res = await ref
                      .watch(foodControllerProvider)
                      .toggleFoodPostAvailablity(
                        "true",
                        widget.food.id!,
                      );
                  if (res == 200) {
                    ShowSnakBar(
                      context: context,
                      content: "Notification was available succesfully",
                    );
                  } else {
                    ShowSnakBar(
                      context: context,
                      content: "something wrong happened",
                    );
                  }
                }
                context.loaderOverlay.hide();
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: 100,
                  child: widget.food.photo == null || widget.food.photo == ""
                      ? Image.asset("images/no_image.png")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: imageFromBase64String(
                            widget.food.photo,
                          ),
                        ),
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
                            // Chip(
                            //   elevation: 2,
                            //   avatar: const Icon(
                            //     Icons.location_on_outlined,
                            //   ),
                            //   padding: const EdgeInsets.all(2),
                            //   backgroundColor:
                            //       const Color.fromARGB(255, 204, 226, 233),
                            //   // label: Text(
                            //   //   '${distanceInMeters.toStringAsFixed(1)} km',
                            //   //   style: const TextStyle(
                            //   //     color: Colors.white,
                            //   //   ),
                            //   // ),
                            // ),
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
