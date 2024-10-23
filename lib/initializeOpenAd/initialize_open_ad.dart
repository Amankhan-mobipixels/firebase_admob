import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Initializes an open ad on the native side with the given [unitId] and
/// specifies a [screenDoNotWantToShow] where the ad should not be shown.
Future<void> initializeOpenAd(
    String unitId, String screenDoNotWantToShow) async {
  const MethodChannel platform = MethodChannel('firebase_admob');
  try {
    await platform.invokeMethod('InitializeOpenAd',
        {"id": unitId, "screenName": screenDoNotWantToShow});
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("Failed to initialize open ad: '${e.message}'");
    }
  }
}
