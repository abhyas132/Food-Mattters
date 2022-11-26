import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/leader_board_model.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Board extends ConsumerWidget {
  LeaderBoardModel lm;
  int i;
  Board({super.key, required this.lm, required this.i});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userDataProvider).user.userId;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GlobalVariables.greyBackgroundCOlor,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          "#${i + 1}",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Text(
          lm.userName,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: lm.userId == uid ? Colors.yellow : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
        ),
        Text(
          "${lm.pp}",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}
