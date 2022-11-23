import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodRequestScreen extends ConsumerStatefulWidget {
  const FoodRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FoodRequestScreenState();
}

class _FoodRequestScreenState extends ConsumerState<FoodRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
