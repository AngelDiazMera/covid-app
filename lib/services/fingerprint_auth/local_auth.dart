import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  // Check if the device can implement biometrics
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  // Get the user's biometrics
  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }

  // Implements biometrics authentication
  static Future<bool> fingerprintAuth() async {
    // Check if the device can implement biometrics
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    // If the device can implement biometrics, then authenticate
    try {
      return await _auth.authenticate(
        biometricOnly: true,
        localizedReason: 'Usa tu huella para ingresar a la app',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
}
