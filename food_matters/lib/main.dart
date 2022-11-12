import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_matters/features/auth/screens/phone_signIN_screen.dart';
import 'package:food_matters/firebase_options.dart';
import 'package:food_matters/screens/home_screen.dart';
import 'package:food_matters/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "food_matters",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: FoodMatters()));
}

class FoodMatters extends ConsumerWidget {
  FoodMatters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food matters',
      home: OtpScreen(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return const OtpScreen();
  }
}
