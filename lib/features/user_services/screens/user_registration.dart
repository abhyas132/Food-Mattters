import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/RegistrationScreen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  void _determinePosition() async {
    isLoad = true;
    setState(() {});
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
    } else {
      curr_pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      print(
        curr_pos!.latitude.toString(),
      );
      if (curr_pos != null) {
        lat = curr_pos!.latitude.toString();
        long = curr_pos!.longitude.toString();
      }
    }
    isLoad = false;
    setState(() {});
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  String userType = "Consumer";
  bool isLoad = false;
  String lat = "", long = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final docIdController = TextEditingController();
  final locationController = TextEditingController();
  final fcsNode = FocusNode();
  String? mtoken;
  Position? curr_pos;

  final inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 3),
      borderRadius: BorderRadius.circular(16),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    docIdController.dispose();
    fcsNode.dispose();
    locationController.dispose();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
    });
  }

  void registerUser() async {
    isLoading = true;
    setState(() {});
    await ref.watch(userControllerProvider).registerUser(
          userId: auth.currentUser!.uid,
          phoneNumber: auth.currentUser!.phoneNumber,
          latitude: '54.2',
          longitude: '65.56',
          fcmToken: mtoken,
          name: nameController.text.trim(),
          addressString: addressController.text.trim(),
          email: emailController.text.trim(),
          userType: userType.trim(),
          documentId: docIdController.text.trim(),
          context: context,
        );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userController = ref.watch(userControllerProvider);

    return isLoading
        ? Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: Text(
                "Please wait...",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: const Text(
                'user registration',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              centerTitle: true,
              actions: [
                isLoading
                    ? const CupertinoActivityIndicator(
                        color: Colors.blue,
                      )
                    : IconButton(
                        onPressed: () {
                          registerUser();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.green.shade900,
                        child: const Icon(Icons.person),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              context: context,
                              builder: (ctx) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 45, 10, 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text('Upload image from'),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: ElevatedButton(
                                          child: const Text('Camera'),
                                          onPressed: () {
                                            userController.selectImage(true);
                                          },
                                        ),
                                      ),
                                      const Text('OR'),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: ElevatedButton(
                                            child: const Text('Gallery'),
                                            onPressed: () {
                                              userController.selectImage(false);
                                            },
                                          )),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text(
                          'upload profile picture',
                          style: TextStyle(color: Colors.green),
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Indentify yourself as",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          "Consumer",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Radio(
                            activeColor: Colors.red,
                            value: "Consumer",
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = "Consumer";
                              });
                            },
                          ),
                        ),
                        Text(
                          "Provider",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Radio(
                            activeColor: Colors.red,
                            value: "Provider",
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = "Provider";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        decoration: inputDecoration.copyWith(hintText: 'Name'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: inputDecoration.copyWith(hintText: 'email'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: docIdController,
                        decoration:
                            inputDecoration.copyWith(hintText: 'documentID'),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        maxLines: null,
                        focusNode: fcsNode,
                        controller: addressController,
                        decoration: inputDecoration.copyWith(
                          hintText: 'Full address',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "lattitude : $lat , longitude : $long",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: isLoad
                              ? const CupertinoActivityIndicator(
                                  color: Colors.blue,
                                )
                              : IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    _determinePosition();
                                  },
                                  icon: const Icon(
                                    Icons.my_location,
                                  ),
                                ),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.4,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           GlobalVariables.selectedNavBarColor.withOpacity(
                    //         0.7,
                    //       ),
                    //     ),
                    //     child: Text(
                    //       'Register',
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       registerUser();
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
  }
}
