// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentMonthBudgetHash() =>
    r'2f616a3c6e82e328491f681b59ddef782a84c7d7';

/// See also [currentMonthBudget].
@ProviderFor(currentMonthBudget)
final currentMonthBudgetProvider = AutoDisposeProvider<Budget?>.internal(
  currentMonthBudget,
  name: r'currentMonthBudgetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentMonthBudgetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentMonthBudgetRef = AutoDisposeProviderRef<Budget?>;
String _$budgetsHash() => r'f49658be1ca473e199e1aea36d1e387cb7d97019';

/// See also [Budgets].
@ProviderFor(Budgets)
final budgetsProvider =
    AutoDisposeAsyncNotifierProvider<Budgets, List<Budget>>.internal(
      Budgets.new,
      name: r'budgetsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$budgetsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Budgets = AutoDisposeAsyncNotifier<List<Budget>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
