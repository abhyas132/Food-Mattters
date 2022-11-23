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
import 'package:foods_matters/provider_route/features/food_services/controller/foodpost_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toggle_switch/toggle_switch.dart';

class allfoodwidget extends ConsumerStatefulWidget {
  Food food;
  double? myLat;
  double? myLong;
  allfoodwidget({
    super.key,
    required this.food,
    this.myLat,
    this.myLong,
  });

  @override
  ConsumerState<allfoodwidget> createState() => _foodwidgetState();
}

class _foodwidgetState extends ConsumerState<allfoodwidget> {
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
      onTap: () {},
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.7),
          ),
          child: Column(
            children: [
              Chip(
                backgroundColor: Colors.grey.withOpacity(0.5),
                label: Text(
                  widget.food.createdAt!,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
      ),
    );
  }
}
