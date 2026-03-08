// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;

  /// Serializes this Expense to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call({
    String? id,
    String? title,
    String? category,
    String? amount,
    String? date,
    String? paymentMethod,
  });
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? category = freezed,
    Object? amount = freezed,
    Object? date = freezed,
    Object? paymentMethod = freezed,
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
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
    _$ExpenseImpl value,
    $Res Function(_$ExpenseImpl) then,
  ) = __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? title,
    String? category,
    String? amount,
    String? date,
    String? paymentMethod,
  });
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
    _$ExpenseImpl _value,
    $Res Function(_$ExpenseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? category = freezed,
    Object? amount = freezed,
    Object? date = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(
      _$ExpenseImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseImpl extends _Expense {
  const _$ExpenseImpl({
    this.id,
    this.title,
    this.category,
    this.amount,
    this.date,
    this.paymentMethod,
  }) : super._();

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? category;
  @override
  final String? amount;
  @override
  final String? date;
  @override
  final String? paymentMethod;

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, category: $category, amount: $amount, date: $date, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    category,
    amount,
    date,
    paymentMethod,
  );

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(this);
  }
}

abstract class _Expense extends Expense {
  const factory _Expense({
    final String? id,
    final String? title,
    final String? category,
    final String? amount,
    final String? date,
    final String? paymentMethod,
  }) = _$ExpenseImpl;
  const _Expense._() : super._();

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get category;
  @override
  String? get amount;
  @override
  String? get date;
  @override
  String? get paymentMethod;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
