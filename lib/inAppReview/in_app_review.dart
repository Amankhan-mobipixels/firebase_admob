
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Triggers an in-app review flow on the native side.
Future<void> inAppReview() async {
  const MethodChannel platform = MethodChannel('firebase_admob');
  try {
    await platform.invokeMethod('inAppReview');
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("Failed to show in-app review: '${e.message}'");
    }
  }
}
