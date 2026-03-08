import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget.freezed.dart';
part 'budget.g.dart';

@freezed
class Budget with _$Budget {
  const Budget._(); // Added private constructor to allow custom getters

  const factory Budget({
    String? id,
    required dynamic amount,
    String? month, // Format: YYYY-MM
    String? category,
    String? notes,
  }) = _Budget;

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  double get amountValue {
    final val = amount;
    if (val == null) return 0.0;
    if (val is double) return val;
    if (val is int) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0.0;
    return 0.0;
  }

  String get monthValue => month ?? '';
}
