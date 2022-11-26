import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/request_model.dart';
import 'package:foods_matters/route/features/food_services/controller/foodpost_controller.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/route/features/user_services/screens/hostel/status_tracking_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RequestWidget extends ConsumerStatefulWidget {
  Request rqt;
  RequestWidget({super.key, required this.rqt});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends ConsumerState<RequestWidget> {
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

  void AcceptTheReq({
    required String hostelId,
    required String ngo,
  }) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(
            hostelId: hostelId,
            ngoId: ngo,
          ),
        ),
      );
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String hostelId = ref.watch(userDataProvider).user.userId!;
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Text(
              //       "From : ",
              //       style: GoogleFonts.poppins(
              //         fontSize: 15,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     Chip(
              //       label: Text(
              //         widget.rqt.requestedBy,
              //         style: GoogleFonts.poppins(
              //           fontSize: 15,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Name : ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Chip(
                    label: Text(
                      widget.rqt.name == null
                          ? "not specified"
                          : widget.rqt.name!,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      cancelReq(
                          requestId: widget.rqt.id, newStatus: "Declined");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "Decline",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.watch(foodRepostitoryProvider).CancelReq(
                            newStatus: "Active",
                            requestId: widget.rqt.requestedBy,
                          );
                      print("request status changed");
                      AcceptTheReq(
                        ngo: widget.rqt.requestedBy,
                        hostelId: hostelId,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Accept",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
