import 'package:flutter/services.dart';

/// A class that manages loading and showing interstitial ads.
class AdInterstitial {
  final MethodChannel _platform = MethodChannel('firebase_admob');

  /// Loads the interstitial ad using the provided [id].
  Future<void> load(String id) async {
    try {
      await _platform.invokeMethod('loadInterstitial', {"id": id});
    } on PlatformException catch (e) {
      print("Failed to load interstitial ad: '${e.message}'");
    }
  }

  /// Shows the interstitial ad if it has been loaded.
  Future<void> show() async {
    try {
      await _platform.invokeMethod('showInterstitial');
    } on PlatformException catch (e) {
      print("Failed to show interstitial ad: '${e.message}'");
    }
  }
}
