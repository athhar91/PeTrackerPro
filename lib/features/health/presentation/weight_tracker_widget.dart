import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pe_track/core/api/api_service.dart';

class WeightTrackerWidget extends StatefulWidget {
  const WeightTrackerWidget({super.key});

  @override
  State<WeightTrackerWidget> createState() => _WeightTrackerWidgetState();
}

class _WeightTrackerWidgetState extends State<WeightTrackerWidget> {
  List<dynamic> _weightRecords = [];
  final _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _refreshWeights();
  }

  void _refreshWeights() async {
    final data = await _apiService.getWeights();
    setState(() {
      _weightRecords = data;
    });
  }

  Future<void> _addWeight() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Weight'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Weight (kg)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await _apiService.addWeight({
                  'weight': double.parse(controller.text),
                  'date': DateTime.now().toIso8601String(),
                });
                if (context.mounted) {
                  Navigator.pop(context);
                  _refreshWeights();
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.scale, color: Colors.blueAccent),
                    const SizedBox(width: 12),
                    Text(
                      'Weight Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    LucideIcons.plusCircle,
                    color: Colors.blueAccent,
                  ),
                  onPressed: _addWeight,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: _weightRecords.length < 2
                  ? const Center(
                      child: Text('Add at least 2 entries to see progress'),
                    )
                  : LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _weightRecords.asMap().entries.map((e) {
                              return FlSpot(
                                e.key.toDouble(),
                                e.value['weight'],
                              );
                            }).toList(),
                            isCurved: true,
                            color: Colors.blueAccent,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blueAccent.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            if (_weightRecords.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last: ${_weightRecords.last['weight']} kg',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (_weightRecords.length > 1)
                    Text(
                      '${(_weightRecords.last['weight'] - _weightRecords.first['weight']).toStringAsFixed(1)} kg total change',
                      style: TextStyle(
                        color:
                            (_weightRecords.last['weight'] -
                                    _weightRecords.first['weight']) <=
                                0
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
