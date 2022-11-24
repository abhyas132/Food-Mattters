import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/global_constant.dart';
import '../../../../models/user_model.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class NgoDetails extends StatelessWidget {
  User user;
  static const routeName = './ngoDetails';
  NgoDetails(this.user);

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      //scale: 10,
      width: 200,
      // height: 200,

      fit: BoxFit.fitWidth,
    );
  }

  Future<void> _callNumber(String phoneNumber) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _callNumber(user.phoneNumber!.substring(3));
        },
        child: const Icon(Icons.call),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Text(
          user.name!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  child: imageFromBase64String(
                    user.photo!,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InfoTile(label: 'Name', value: user.name!),
            InfoTile(label: 'E-mail', value: user.addressString!),
            InfoTile(label: 'Phone number', value: user.phoneNumber!),
            InfoTile(label: 'Address', value: user.addressString!),
          ]),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  const InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(children: [
          Expanded(
              child: Text(
            label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          )),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
      ),
    );
  }
}
