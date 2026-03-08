// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetImpl _$$BudgetImplFromJson(Map<String, dynamic> json) => _$BudgetImpl(
  id: json['id'] as String?,
  amount: json['amount'],
  month: json['month'] as String?,
  category: json['category'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$BudgetImplToJson(_$BudgetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'month': instance.month,
      'category': instance.category,
      'notes': instance.notes,
    };
