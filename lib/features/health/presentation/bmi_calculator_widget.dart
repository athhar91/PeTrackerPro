import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BMICalculatorWidget extends StatefulWidget {
  const BMICalculatorWidget({super.key});

  @override
  State<BMICalculatorWidget> createState() => _BMICalculatorWidgetState();
}

class _BMICalculatorWidgetState extends State<BMICalculatorWidget> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;
  String _message = 'Enter your details to calculate BMI';
  Color _messageColor = Colors.white70;

  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      // BMI = weight(kg) / height(m)^2
      final heightInMeters = height / 100;
      setState(() {
        _bmi = weight / (heightInMeters * heightInMeters);
        _setBMIStatus();
      });
    }
  }

  void _setBMIStatus() {
    if (_bmi == null) return;
    if (_bmi! < 18.5) {
      _message = 'Underweight';
      _messageColor = Colors.blueAccent;
    } else if (_bmi! < 25) {
      _message = 'Normal';
      _messageColor = Colors.greenAccent;
    } else if (_bmi! < 30) {
      _message = 'Overweight';
      _messageColor = Colors.orangeAccent;
    } else {
      _message = 'Obese';
      _messageColor = Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(LucideIcons.activity, color: Colors.greenAccent),
                const SizedBox(width: 12),
                Text(
                  'BMI Calculator',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Height (cm)',
                      hintText: 'e.g. 175',
                    ),
                    onChanged: (_) => _calculateBMI(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      hintText: 'e.g. 70',
                    ),
                    onChanged: (_) => _calculateBMI(),
                  ),
                ),
              ],
            ),
            if (_bmi != null) ...[
              const SizedBox(height: 24),
              Text(
                _bmi!.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _messageColor,
                ),
              ),
              Text(
                _message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _messageColor,
                ),
              ),
            ] else ...[
              const SizedBox(height: 24),
              const Text('Enter height and weight'),
            ],
          ],
        ),
      ),
    );
  }
}
