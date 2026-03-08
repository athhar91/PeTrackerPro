import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to access GymTrack Pro',
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      print('Biometric error: $e');
      return false;
    }
  }
}
