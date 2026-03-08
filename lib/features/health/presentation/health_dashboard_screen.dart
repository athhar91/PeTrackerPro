import 'package:flutter/material.dart';
import 'package:pe_track/features/health/presentation/bmi_calculator_widget.dart';
import 'package:pe_track/features/health/presentation/weight_tracker_widget.dart';

class HealthDashboardScreen extends StatelessWidget {
  const HealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health & Weight')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            WeightTrackerWidget(),
            SizedBox(height: 16),
            BMICalculatorWidget(),
          ],
        ),
      ),
    );
  }
}
