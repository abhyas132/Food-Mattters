import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/request_model.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CRequestWidget extends ConsumerStatefulWidget {
  Request rqt;
  CRequestWidget({super.key, required this.rqt});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CRequestWidgetState();
}

class _CRequestWidgetState extends ConsumerState<CRequestWidget> {
  void cancelReq({
    required requestId,
    required newStatus,
  }) async {
    context.loaderOverlay.show();
    final res = await ref.watch(foodControllerProvider).CancelReq(
          requestId: requestId,
          newStatus: newStatus,
        );
    context.loaderOverlay.hide();
    if (res == 200) {
      ShowSnakBar(
        context: context,
        content: "The request was cancelled by you",
      );
    } else {
      ShowSnakBar(
        context: context,
        content: "Some error happened",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        margin:
            const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Request Id : ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Chip(
                    label: Text(
                      widget.rqt.id,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "From : ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Chip(
                    label: Text(
                      widget.rqt.requestedBy,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Request Status : ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Chip(
                    label: Text(
                      widget.rqt.requestStatus,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
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
