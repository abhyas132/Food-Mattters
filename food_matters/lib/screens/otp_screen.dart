import 'package:flutter/material.dart';
import 'package:food_matters/providers/auth_service.dart';
import 'package:provider/provider.dart';
import '../constants/screen_size.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService authenticationService =
        Provider.of<AuthenticationService>(context);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/food3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '(+91) ',
                      labelText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  verticalSpaceMedium,
                  GestureDetector(
                    onTap: () async {
                      await authenticationService.signinWithOTP('6290080262');
                    },
                    child: Container(
                      width: screenWidth(context) * 0.6,
                      height: screenHeight(context) * 0.09,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(child: Text('Send OTP')),
                    ),
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}
