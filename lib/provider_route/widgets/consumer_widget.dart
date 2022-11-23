import 'dart:convert';
import 'dart:ffi';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class Consumerwidget extends StatefulWidget {
  User user;
  double myLat;
  double myLong;
  Consumerwidget({
    super.key,
    required this.user,
    required this.myLat,
    required this.myLong,
  });

  @override
  State<Consumerwidget> createState() => _ConsumerwidgetState();
}

class _ConsumerwidgetState extends State<Consumerwidget> {
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

    double distanceInMeters = Geolocator.distanceBetween(
      widget.user.latitude == null ? 0.5 : widget.user.latitude!,
      widget.user.longitude == null ? 0.8 : widget.user.longitude!,
      widget.myLat,
      widget.myLong,
    );
    //print(widget.user.latitude);
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.2,
            width: 100,
            child: widget.user.photo == null
                ? Image.asset("images/no_image.png")
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: imageFromBase64String(
                      widget.user.photo!,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user.name!,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        IconData(
                          0xe699,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.user.email!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.user.addressString!,
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Badge(
                        //gradient: GlobalVariables.appBarGradient,
                        elevation: 3,
                        badgeColor: Colors.white,
                        badgeContent: Text(widget.user.name!.length.toString()),
                        child: const Icon(
                          Icons.people,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Chip(
                        elevation: 2,
                        avatar: const Icon(
                          Icons.location_on_outlined,
                        ),
                        padding: const EdgeInsets.all(2),
                        backgroundColor:
                            const Color.fromARGB(255, 204, 226, 233),
                        label: Text(
                          '${distanceInMeters.toStringAsFixed(1)} km',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
