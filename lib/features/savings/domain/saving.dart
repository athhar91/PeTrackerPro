import 'package:freezed_annotation/freezed_annotation.dart';

part 'saving.freezed.dart';
part 'saving.g.dart';

@freezed
class Saving with _$Saving {
  const Saving._();

  const factory Saving({
    String? id,
    String? title,
    double? targetAmount,
    double? currentAmount,
    String? category,
    String? createdAt,
  }) = _Saving;

  factory Saving.fromJson(Map<String, dynamic> json) => _$SavingFromJson(json);

  double get progress {
    if (targetAmount == null || targetAmount == 0) return 0.0;
    return (currentAmount ?? 0.0) / targetAmount!;
  }

  String get amountDisplay => '\$${currentAmount?.toStringAsFixed(0) ?? '0'}';
  String get targetDisplay => '\$${targetAmount?.toStringAsFixed(0) ?? '0'}';
}
