import 'package:flutter/material.dart';
import 'package:food_matters/providers/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget LoginUiWidget2(BuildContext context) {
  TextEditingController phoneNum = TextEditingController();
  final AuthenticationService authenticationService =
      Provider.of<AuthenticationService>(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, nice to meet you!',
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
            fontSize: 15,
          ),
        ),
        Text(
          'Let\'s get started with food matters',
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 3,
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '+91',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 45,
                color: Colors.black.withOpacity(0.2),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TextField(
                    controller: phoneNum,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                      hintText: "Enter your mobile number",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.3,
          ),
          child: ElevatedButton(
            onPressed: () async {
              await authenticationService.signinWithOTP(phoneNum.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 154, 230, 156),
              elevation: 2,
            ),
            child: Text(
              'Next',
              style: GoogleFonts.poppins(fontSize: 30),
            ),
          ),
        )
      ],
    )),
  );
}
