import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:pe_track/features/budget/presentation/budget_provider.dart';
import 'package:pe_track/features/add_expenses/presentation/expenses_provider.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(budgetsProvider);
    final currentBudget = ref.watch(currentMonthBudgetProvider);
    final dailyStats = ref.watch(dailyStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Budget'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.go('/'),
        ),
      ),
      body: budgetsAsync.when(
        data:
            (budgets) => SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurrentMonthHeader(context, currentBudget, dailyStats),
                  const SizedBox(height: 32),
                  Text(
                    'Budget History',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  if (budgets.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text('No budgets set yet.'),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        final budget = budgets[index];
                        return _buildBudgetCard(context, budget);
                      },
                    ),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBudgetDialog(context, ref),
        label: const Text('Set Budget'),
        icon: const Icon(LucideIcons.plus),
      ),
    );
  }

  Widget _buildCurrentMonthHeader(
    BuildContext context,
    dynamic currentBudget,
    dynamic dailyStats,
  ) {
    final now = DateTime.now();
    final monthName = DateFormat('MMMM yyyy').format(now);
    final budgetAmount = currentBudget?.amountValue ?? 0.0;

    // Total expenses for the month - we'd need a provider for this ideally
    // For now, let's use a placeholder or calculate from expensesProvider
    // But let's keep it simple for the UI first

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.8),
            Theme.of(context).primaryColor.withValues(alpha: 0.4),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            monthName,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            budgetAmount > 0
                ? '\$${budgetAmount.toStringAsFixed(0)}'
                : 'Not Set',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65, // Placeholder for utilization
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '65% of budget utilized',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildBudgetCard(BuildContext context, dynamic budget) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.calendar,
            color: Colors.blueAccent,
            size: 20,
          ),
        ),
        title: Text(
          budget.monthValue.isNotEmpty
              ? DateFormat(
                'MMMM yyyy',
              ).format(DateTime.parse('${budget.monthValue}-01'))
              : 'Unknown Month',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '\$${budget.amountValue.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }

  void _showAddBudgetDialog(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    final now = DateTime.now();
    final currentMonth = DateFormat('yyyy-MM').format(now);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 32,
              top: 32,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Set Monthly Budget',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'For ${DateFormat('MMMM yyyy').format(now)}',
                  style: const TextStyle(color: Colors.white60),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    labelText: 'Amount',
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      final amount = double.tryParse(amountController.text);
                      if (amount != null) {
                        await ref
                            .read(budgetsProvider.notifier)
                            .addBudget(amount: amount, month: currentMonth);
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Budget updated! ✨')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Save Budget',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
