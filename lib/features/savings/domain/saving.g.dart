// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavingImpl _$$SavingImplFromJson(Map<String, dynamic> json) => _$SavingImpl(
  id: json['id'] as String?,
  title: json['title'] as String?,
  targetAmount: (json['targetAmount'] as num?)?.toDouble(),
  currentAmount: (json['currentAmount'] as num?)?.toDouble(),
  category: json['category'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$SavingImplToJson(_$SavingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'targetAmount': instance.targetAmount,
      'currentAmount': instance.currentAmount,
      'category': instance.category,
      'createdAt': instance.createdAt,
    };
