// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalSavingsHash() => r'0038c23f1742fc02a81ff6772a9e887aede45faa';

/// See also [totalSavings].
@ProviderFor(totalSavings)
final totalSavingsProvider = AutoDisposeProvider<double>.internal(
  totalSavings,
  name: r'totalSavingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalSavingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalSavingsRef = AutoDisposeProviderRef<double>;
String _$totalTargetHash() => r'2385b67dc854d11b315fd402c60e51f5491a93e6';

/// See also [totalTarget].
@ProviderFor(totalTarget)
final totalTargetProvider = AutoDisposeProvider<double>.internal(
  totalTarget,
  name: r'totalTargetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalTargetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalTargetRef = AutoDisposeProviderRef<double>;
String _$savingsHash() => r'06ccb2be69babb4605966bc9038bb9f8f902e8db';

/// See also [Savings].
@ProviderFor(Savings)
final savingsProvider =
    AutoDisposeAsyncNotifierProvider<Savings, List<Saving>>.internal(
      Savings.new,
      name: r'savingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Savings = AutoDisposeAsyncNotifier<List<Saving>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
