// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      amount: json['amount'] as String?,
      date: json['date'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'amount': instance.amount,
      'date': instance.date,
      'paymentMethod': instance.paymentMethod,
    };
