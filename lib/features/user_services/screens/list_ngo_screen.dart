import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';

class ListOfNgoScreen extends ConsumerStatefulWidget {
  const ListOfNgoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListOfNgoScreenState();
}

class _ListOfNgoScreenState extends ConsumerState<ListOfNgoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: GlobalVariables.selectedNavBarColor,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              'share',
            ),
          ),
        ),
      ),
    );
  }
}
