import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/features/auth/screens/otp_screen.dart';
import 'package:foods_matters/features/user_services/controller/user_controller.dart';
import 'package:foods_matters/features/user_services/screens/user_registration.dart';
import 'package:foods_matters/firebase_options.dart';
import 'package:foods_matters/router.dart';
import 'package:foods_matters/widgets/bottom_bar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a backgound message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: ref.watch(userDataControllerProvider).when(
      //       data: (user) {
      //         if (user == null) {
      //           return const OTPScreen();
      //         } else {
      //           return const BottomBar();
      //         }
      //       },
      //       error: (err, trace) {},
      //       loading: () {
      //         return const Scaffold(
      //           body: Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //         );
      //       },
      //     ),
      home: RegistrationScreen(),
    );
  }
}
