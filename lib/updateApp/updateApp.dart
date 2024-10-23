
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Calls the native method to trigger an app update process.
///
/// This method invokes the platform-specific functionality to check for and
/// perform an app update if available.
///
/// Throws a [PlatformException] if the method fails to execute on the native
/// platform.
///
/// Example usage:
/// ```dart
/// await updateApp();
/// ```
Future<void> updateApp() async {
  const MethodChannel platform = MethodChannel('firebase_admob');
  try {
    await platform.invokeMethod('updateApp');
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("Failed to show updateApp: '${e.message}'");
    }
  }
}
