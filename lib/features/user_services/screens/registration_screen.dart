import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';

final inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 3),
      borderRadius: BorderRadius.circular(16),
    ));

class RegistrationScreen extends ConsumerWidget {
  static const String routeName = '/RegistrationScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.read(userControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
                                top: Radius.circular(16))),
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
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'Name',
                ),
              ),
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'email',
                ),
              ),
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'address',
                ),
              ),
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'userType',
                ),
              ),
              TextField(
                decoration: inputDecoration,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {},
                ),
              )
            ]),
      ),
    );
  }
}
