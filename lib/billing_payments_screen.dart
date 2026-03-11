import 'package:flutter/material.dart';

class BillingPaymentsScreen extends StatelessWidget {
  const BillingPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billing & Payments')),
      body: const Center(child: Text('Billing & Payments Screen')),
    );
  }
}
