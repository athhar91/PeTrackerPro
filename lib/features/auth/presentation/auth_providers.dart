import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pe_track/features/auth/domain/biometric_service.dart';
import 'package:pe_track/core/api/api_service.dart';

final biometricServiceProvider = Provider((ref) => BiometricService());

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(
    ref.read(biometricServiceProvider),
    ref.read(apiServiceProvider),
  );
});

class AuthNotifier extends StateNotifier<bool> {
  final BiometricService _biometricService;
  final ApiService _apiService;

  AuthNotifier(this._biometricService, this._apiService) : super(false);

  Future<bool> login(String username, String password) async {
    final success = await _apiService.login(username, password);
    if (success) {
      state = true;
    }
    return success;
  }

  Future<void> loginWithBiometrics() async {
    final success = await _biometricService.authenticate();
    if (success) {
      state = true;
    }
  }

  void logout() {
    state = false;
  }
}
