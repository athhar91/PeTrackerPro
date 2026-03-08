import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  const Expense._(); // Added private constructor to allow custom getters

  const factory Expense({
    String? id,
    String? title,
    String? category,
    String? amount,
    String? date,
    String? paymentMethod,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  String get titleValue => title ?? '';
  String get categoryValue => category ?? 'General';
  String get amountValue => amount ?? '0';
  String get dateValue => date ?? '';
  String get paymentMethodValue => paymentMethod ?? 'Cash';
}
