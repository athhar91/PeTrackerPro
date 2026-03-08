import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pe_track/core/api/api_service.dart';
import 'package:pe_track/features/savings/domain/saving.dart';

part 'savings_provider.g.dart';

@riverpod
class Savings extends _$Savings {
  @override
  Future<List<Saving>> build() async {
    final apiService = ref.watch(apiServiceProvider);
    final data = await apiService.getSavings();
    return data.map((e) => Saving.fromJson(e)).toList();
  }

  Future<void> addSaving(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final savingData = {...data, 'id': id};
      await apiService.addSaving(savingData);
      final newData = await apiService.getSavings();
      return newData.map((e) => Saving.fromJson(e)).toList();
    });
  }

  Future<void> updateSaving(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      await apiService.updateSaving(id, data);
      final newData = await apiService.getSavings();
      return newData.map((e) => Saving.fromJson(e)).toList();
    });
  }

  Future<void> deleteSaving(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      await apiService.deleteSaving(id);
      final newData = await apiService.getSavings();
      return newData.map((e) => Saving.fromJson(e)).toList();
    });
  }
}

@riverpod
double totalSavings(TotalSavingsRef ref) {
  final savingsAsync = ref.watch(savingsProvider);
  return savingsAsync.maybeWhen(
    data:
        (savings) =>
            savings.fold(0.0, (sum, item) => sum + (item.currentAmount ?? 0.0)),
    orElse: () => 0.0,
  );
}

@riverpod
double totalTarget(TotalTargetRef ref) {
  final savingsAsync = ref.watch(savingsProvider);
  return savingsAsync.maybeWhen(
    data:
        (savings) =>
            savings.fold(0.0, (sum, item) => sum + (item.targetAmount ?? 0.0)),
    orElse: () => 0.0,
  );
}
