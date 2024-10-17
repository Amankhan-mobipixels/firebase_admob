import 'package:flutter/services.dart';

class AdInterstitial {
    final MethodChannel _platform = MethodChannel('firebase_admob');
  // Load the Interstitial Ad

  Future<void> load(String id) async {
    try {
      await _platform.invokeMethod('loadInterstitial',{"id": id});
    } on PlatformException catch (e) {
      print("Failed to load interstitial ad: '${e.message}'");
    }
  }

  // Show the Interstitial Ad
  Future<void> show() async {
    try {
      await _platform.invokeMethod('showInterstitial');
    } on PlatformException catch (e) {
      print("Failed to show interstitial ad: '${e.message}'");
    }
  }
}
