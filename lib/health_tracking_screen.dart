import 'package:flutter/material.dart';

class HealthTrackingScreen extends StatelessWidget {
  const HealthTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Tracking')),
      body: const Center(child: Text('Health Tracking Screen')),
    );
  }
}
