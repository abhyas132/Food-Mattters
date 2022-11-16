import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusTrackingScreen extends ConsumerStatefulWidget {
  const StatusTrackingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StatusTrackingScreenState();
}

class _StatusTrackingScreenState extends ConsumerState<StatusTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Center(child: Text('status'))]),
    );
  }
}
