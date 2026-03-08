// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saving.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Saving _$SavingFromJson(Map<String, dynamic> json) {
  return _Saving.fromJson(json);
}

/// @nodoc
mixin _$Saving {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  double? get targetAmount => throw _privateConstructorUsedError;
  double? get currentAmount => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Saving to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Saving
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavingCopyWith<Saving> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingCopyWith<$Res> {
  factory $SavingCopyWith(Saving value, $Res Function(Saving) then) =
      _$SavingCopyWithImpl<$Res, Saving>;
  @useResult
  $Res call({
    String? id,
    String? title,
    double? targetAmount,
    double? currentAmount,
    String? category,
    String? createdAt,
  });
}

/// @nodoc
class _$SavingCopyWithImpl<$Res, $Val extends Saving>
    implements $SavingCopyWith<$Res> {
  _$SavingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Saving
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? targetAmount = freezed,
    Object? currentAmount = freezed,
    Object? category = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetAmount: freezed == targetAmount
                ? _value.targetAmount
                : targetAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            currentAmount: freezed == currentAmount
                ? _value.currentAmount
                : currentAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavingImplCopyWith<$Res> implements $SavingCopyWith<$Res> {
  factory _$$SavingImplCopyWith(
    _$SavingImpl value,
    $Res Function(_$SavingImpl) then,
  ) = __$$SavingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? title,
    double? targetAmount,
    double? currentAmount,
    String? category,
    String? createdAt,
  });
}

/// @nodoc
class __$$SavingImplCopyWithImpl<$Res>
    extends _$SavingCopyWithImpl<$Res, _$SavingImpl>
    implements _$$SavingImplCopyWith<$Res> {
  __$$SavingImplCopyWithImpl(
    _$SavingImpl _value,
    $Res Function(_$SavingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Saving
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? targetAmount = freezed,
    Object? currentAmount = freezed,
    Object? category = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SavingImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetAmount: freezed == targetAmount
            ? _value.targetAmount
            : targetAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        currentAmount: freezed == currentAmount
            ? _value.currentAmount
            : currentAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavingImpl extends _Saving {
  const _$SavingImpl({
    this.id,
    this.title,
    this.targetAmount,
    this.currentAmount,
    this.category,
    this.createdAt,
  }) : super._();

  factory _$SavingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavingImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final double? targetAmount;
  @override
  final double? currentAmount;
  @override
  final String? category;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'Saving(id: $id, title: $title, targetAmount: $targetAmount, currentAmount: $currentAmount, category: $category, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    targetAmount,
    currentAmount,
    category,
    createdAt,
  );

  /// Create a copy of Saving
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavingImplCopyWith<_$SavingImpl> get copyWith =>
      __$$SavingImplCopyWithImpl<_$SavingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavingImplToJson(this);
  }
}

abstract class _Saving extends Saving {
  const factory _Saving({
    final String? id,
    final String? title,
    final double? targetAmount,
    final double? currentAmount,
    final String? category,
    final String? createdAt,
  }) = _$SavingImpl;
  const _Saving._() : super._();

  factory _Saving.fromJson(Map<String, dynamic> json) = _$SavingImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  double? get targetAmount;
  @override
  double? get currentAmount;
  @override
  String? get category;
  @override
  String? get createdAt;

  /// Create a copy of Saving
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavingImplCopyWith<_$SavingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
