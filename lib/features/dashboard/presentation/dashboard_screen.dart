import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_track/features/auth/presentation/auth_providers.dart';
import 'package:pe_track/features/add_expenses/presentation/expenses_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PETrack Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.logOut),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.push('/admin'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildQuickSummary(context, ref),
            const SizedBox(height: 24),
            _buildProgressOverview(context, ref),
            const SizedBox(height: 24),
            _buildExpenseTrend(context),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin'),
        label: const Text('Admin Panel'),
        icon: const Icon(LucideIcons.database),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                label: 'Add Expense',
                icon: LucideIcons.receipt,
                color: Colors.orangeAccent,
                onTap:
                    () => context.push(
                      '/add_expenses',
                    ), // Placeholder for expense entry
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _QuickActionButton(
                label: 'Budget',
                icon: LucideIcons.wallet,
                color: Colors.blueAccent,
                onTap: () => context.go('/budget'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _QuickActionButton(
                label: 'Savings',
                icon: LucideIcons.piggyBank,
                color: Colors.greenAccent,
                onTap: () => context.push('/health'), // Placeholder
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildQuickSummary(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dailyStatsProvider);

    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Daily Spend',
            value:
                stats != null
                    ? '\$${stats.todayTotal.toStringAsFixed(stats.todayTotal % 1 == 0 ? 0 : 2)}'
                    : '...',
            subtitle:
                stats != null
                    ? '${stats.isIncrease ? '+' : '-'}${stats.percentageChange.toStringAsFixed(1)}% from yesterday'
                    : 'Loading...',
            color: Colors.orangeAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _SummaryCard(
            title: 'Monthly Budget',
            value: '\$2.5k',
            subtitle: '65% utilized',
            color: Colors.redAccent,
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildProgressOverview(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(categoryStatsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress Overview (DYNAMIC)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            if (stats.isEmpty)
              const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'No expense data available',
                    style: TextStyle(color: Colors.white38),
                  ),
                ),
              )
            else ...[
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 40,
                    sections:
                        stats.map((stat) {
                          return _buildPieSection(
                            stat.category,
                            stat.percentage,
                            _getCategoryColor(stat.category),
                          );
                        }).toList(),
                  ),
                ).animate().rotate(duration: 800.ms),
              ),
              const SizedBox(height: 20),
              _buildLegend(stats),
            ],
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.blueAccent;
      case 'Transport':
        return Colors.purpleAccent;
      case 'Entertainment':
        return Colors.pinkAccent;
      case 'Shopping':
        return Colors.cyanAccent;
      case 'Bills':
        return Colors.orangeAccent;
      case 'Rent':
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  PieChartSectionData _buildPieSection(
    String title,
    double value,
    Color color,
  ) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '${value.toStringAsFixed(0)}%',
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLegend(List<CategoryStat> stats) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children:
          stats.map((stat) {
            return _LegendItem(
              label: stat.category,
              color: _getCategoryColor(stat.category),
            );
          }).toList(),
    );
  }

  Widget _buildExpenseTrend(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Spending',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                            'Jun',
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                months[value.toInt()],
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        reservedSize: 28,
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  barGroups: [
                    _buildBarGroup(0, 5),
                    _buildBarGroup(1, 4),
                    _buildBarGroup(2, 6),
                    _buildBarGroup(3, 3),
                    _buildBarGroup(4, 5),
                    _buildBarGroup(5, 7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.orangeAccent,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withValues(alpha: 0.2), Colors.transparent],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: color, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withValues(alpha: 0.1), Colors.transparent],
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
