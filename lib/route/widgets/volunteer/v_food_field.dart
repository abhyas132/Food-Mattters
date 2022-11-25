import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class VFoodField extends ConsumerStatefulWidget {
  Food food;
  double? myLat;
  double? myLong;
  VFoodField({
    super.key,
    required this.food,
    this.myLat,
    this.myLong,
  });

  @override
  ConsumerState<VFoodField> createState() => _VFoodFieldState();
}

class _VFoodFieldState extends ConsumerState<VFoodField> {
  bool value = false;
  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      width: 200,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            !value
                                ? Text(
                                    "select this Food Post?",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(
                                    "selected                          ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                            Checkbox(
                              value: value,
                              onChanged: (v) {
                                setState(() {
                                  value = v!;
                                });
                              },
                            ),
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
