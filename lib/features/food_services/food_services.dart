import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddFoodInfo extends StatefulWidget {
  const AddFoodInfo({super.key});

  @override
  State<AddFoodInfo> createState() => _AddFoodInfoState();
}

class _AddFoodInfoState extends State<AddFoodInfo> {
  final TextEditingController food_list = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
