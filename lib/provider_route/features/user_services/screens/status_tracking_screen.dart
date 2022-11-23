import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/provider_route/widgets/clock_widget.dart';

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
      body: Center(
        child: ClockWidget(),
      ),
    );
  }
}
