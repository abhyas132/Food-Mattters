import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderBoardWidget extends ConsumerStatefulWidget {
  const LeaderBoardWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaderBoardWidgetState();
}

class _LeaderBoardWidgetState extends ConsumerState<LeaderBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/king.png",
          height: 70,
          width: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            height: 70,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  //color: Colors.red,
                  ),
              image: const DecorationImage(
                image: AssetImage("images/circle12.png"),
                fit: BoxFit.fill,
              ),
            ),
            //  child: Text(""),
          ),
        ),
      ],
    );
  }
}
