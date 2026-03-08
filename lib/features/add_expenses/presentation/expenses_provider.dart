import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_track/core/api/api_service.dart';
import 'package:pe_track/features/add_expenses/domain/expense.dart';

part 'expenses_provider.g.dart';

@riverpod
class Expenses extends _$Expenses {
  @override
  Future<List<Expense>> build() async {
    final apiService = ref.watch(apiServiceProvider);
    final data = await apiService.getExpenses();
    return data.map((e) => Expense.fromJson(e)).toList();
  }

  Future<void> addExpense(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      // Ensure there's an ID if not provided
      final expenseData = {
        ...data,
        if (data['id'] == null)
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
      };
      await apiService.addExpense(expenseData);
      final newData = await apiService.getExpenses();
      return newData.map((e) => Expense.fromJson(e)).toList();
    });
  }

  Future<void> editExpense(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      await apiService.updateExpense(id, data);
      final newData = await apiService.getExpenses();
      return newData.map((e) => Expense.fromJson(e)).toList();
    });
  }

  Future<void> deleteExpense(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      await apiService.deleteExpense(id);
      final newData = await apiService.getExpenses();
      return newData.map((e) => Expense.fromJson(e)).toList();
    });
  }
}

class DailyStats {
  final double todayTotal;
  final double yesterdayTotal;
  final double percentageChange;
  final bool isIncrease;

  DailyStats({
    required this.todayTotal,
    required this.yesterdayTotal,
    required this.percentageChange,
    required this.isIncrease,
  });
}

@riverpod
DailyStats? dailyStats(DailyStatsRef ref) {
  final expensesAsync = ref.watch(expensesProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      final now = DateTime.now();
      final todayStr =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      final yesterday = now.subtract(const Duration(days: 1));
      final yesterdayStr =
          "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";

      double todayTotal = 0;
      double yesterdayTotal = 0;

      for (final expense in expenses) {
        final amount = double.tryParse(expense.amountValue) ?? 0;
        if (expense.dateValue == todayStr) {
          todayTotal += amount;
        } else if (expense.dateValue == yesterdayStr) {
          yesterdayTotal += amount;
        }
      }

      double percentageChange = 0;
      bool isIncrease = true;

      if (yesterdayTotal > 0) {
        if (todayTotal >= yesterdayTotal) {
          percentageChange =
              ((todayTotal - yesterdayTotal) / yesterdayTotal) * 100;
          isIncrease = true;
        } else {
          percentageChange =
              ((yesterdayTotal - todayTotal) / yesterdayTotal) * 100;
          isIncrease = false;
        }
      } else if (todayTotal > 0) {
        percentageChange = 100;
        isIncrease = true;
      }

      return DailyStats(
        todayTotal: todayTotal,
        yesterdayTotal: yesterdayTotal,
        percentageChange: percentageChange,
        isIncrease: isIncrease,
      );
    },
    orElse: () => null,
  );
}

class CategoryStat {
  final String category;
  final double amount;
  final double percentage;

  CategoryStat({
    required this.category,
    required this.amount,
    required this.percentage,
  });
}

@riverpod
List<CategoryStat> categoryStats(CategoryStatsRef ref) {
  final expensesAsync = ref.watch(expensesProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      if (expenses.isEmpty) return [];

      final Map<String, double> totals = {};
      double grandTotal = 0;

      for (final expense in expenses) {
        final amount = double.tryParse(expense.amountValue) ?? 0;
        totals[expense.categoryValue] =
            (totals[expense.categoryValue] ?? 0) + amount;
        grandTotal += amount;
      }

      if (grandTotal == 0) return [];

      return totals.entries.map((e) {
          return CategoryStat(
            category: e.key,
            amount: e.value,
            percentage: (e.value / grandTotal) * 100,
          );
        }).toList()
        ..sort((a, b) => b.amount.compareTo(a.amount));
    },
    orElse: () => [],
  );
}
