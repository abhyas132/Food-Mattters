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
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.14,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.3,
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
