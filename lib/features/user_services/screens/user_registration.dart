import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/RegistrationScreen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final typeController = TextEditingController();
  final docIdController = TextEditingController();
  String? mtoken;

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
    typeController.dispose();
    docIdController.dispose();
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
    setState(() {
      isLoading = true;
    });
    await ref.watch(userControllerProvider).registerUser(
          userId: auth.currentUser!.uid,
          phoneNumber: auth.currentUser!.phoneNumber,
          latitude: '5412',
          longitude: '65',
          fcmToken: mtoken,
          name: nameController.text,
          addressString: addressController.text,
          email: emailController.text,
          userType: typeController.text,
          documentId: docIdController.text,
          context: context,
        );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userController = ref.watch(userControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'user registration',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.green.shade900,
                child: const Icon(Icons.person),
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
                            padding: const EdgeInsets.fromLTRB(10, 45, 10, 10),
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Upload image from'),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: ElevatedButton(
                                    child: const Text('Camera'),
                                    onPressed: () {
                                      userController.selectImage(true);
                                    },
                                  ),
                                ),
                                const Text('OR'),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
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
              TextFormField(
                controller: nameController,
                decoration: inputDecoration.copyWith(hintText: 'Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: inputDecoration.copyWith(hintText: 'email'),
              ),
              TextFormField(
                controller: addressController,
                decoration: inputDecoration.copyWith(hintText: 'address'),
              ),
              TextFormField(
                controller: typeController,
                decoration: inputDecoration.copyWith(hintText: 'userType'),
              ),
              TextFormField(
                controller: docIdController,
                decoration: inputDecoration.copyWith(hintText: 'documentID'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    registerUser();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
