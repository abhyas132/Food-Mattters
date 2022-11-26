import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:google_fonts/google_fonts.dart';

class Board extends StatelessWidget {
  String numb;
  Board({super.key, required this.numb});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: GlobalVariables.greyBackgroundCOlor,
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Text(
            "1",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
