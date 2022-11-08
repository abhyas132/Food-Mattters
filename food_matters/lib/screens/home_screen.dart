import 'package:flutter/material.dart';
import 'package:food_matters/providers/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationService>(context);

    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text('Logout'),
        onPressed: () => auth.signOut(),
      )),
    );
  }
}
