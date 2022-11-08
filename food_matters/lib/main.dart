import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_matters/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'providers/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
      ],
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
