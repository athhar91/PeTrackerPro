// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyStatsHash() => r'fe5ca37036a7df30eca4d128f02d9cba0514a91d';

/// See also [dailyStats].
@ProviderFor(dailyStats)
final dailyStatsProvider = AutoDisposeProvider<DailyStats?>.internal(
  dailyStats,
  name: r'dailyStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyStatsRef = AutoDisposeProviderRef<DailyStats?>;
String _$categoryStatsHash() => r'458195bca73ece055bc296fb90df7cb17cf50b95';

/// See also [categoryStats].
@ProviderFor(categoryStats)
final categoryStatsProvider = AutoDisposeProvider<List<CategoryStat>>.internal(
  categoryStats,
  name: r'categoryStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryStatsRef = AutoDisposeProviderRef<List<CategoryStat>>;
String _$expensesHash() => r'91d6fe068938cb1754d63829d90bbd0c640a731b';

/// See also [Expenses].
@ProviderFor(Expenses)
final expensesProvider =
    AutoDisposeAsyncNotifierProvider<Expenses, List<Expense>>.internal(
      Expenses.new,
      name: r'expensesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$expensesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Expenses = AutoDisposeAsyncNotifier<List<Expense>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
