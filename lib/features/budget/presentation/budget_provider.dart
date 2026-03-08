import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pe_track/core/api/api_service.dart';
import 'package:pe_track/features/budget/domain/budget.dart';
import 'package:intl/intl.dart';

part 'budget_provider.g.dart';

@riverpod
class Budgets extends _$Budgets {
  @override
  Future<List<Budget>> build() async {
    final apiService = ref.watch(apiServiceProvider);
    final data = await apiService.getBudgets();
    return data.map((e) => Budget.fromJson(e)).toList();
  }

  Future<void> addBudget({
    required double amount,
    required String month,
    String? category,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      await apiService.addBudget({
        'amount': amount.toString(),
        'month': month,
        'category': category,
        'notes': notes,
      });
      final newData = await apiService.getBudgets();
      return newData.map((e) => Budget.fromJson(e)).toList();
    });
  }
}

@riverpod
Budget? currentMonthBudget(CurrentMonthBudgetRef ref) {
  final budgetsAsync = ref.watch(budgetsProvider);
  final currentMonth = DateFormat('yyyy-MM').format(DateTime.now());

  return budgetsAsync.maybeWhen(
    data: (budgets) {
      try {
        return budgets.firstWhere((b) => b.monthValue == currentMonth);
      } catch (_) {
        return null;
      }
    },
    orElse: () => null,
  );
}
