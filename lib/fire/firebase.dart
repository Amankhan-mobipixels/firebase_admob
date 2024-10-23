import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Fires an event with the specified [name] to the native side.
Future<void> fireEvent(String name) async {
  await _invokeMethod('fireEvent', {"eventName": name}, "Failed to fire event");
}

/// Initializes Firebase messaging with the specified [name] for a topic.
Future<void> initializeFirebaseMessaging(String name) async {
  await _invokeMethod('initializeFirebaseMessaging', {"topicName": name},
      "Failed to initialize Firebase Messaging");
}

/// A private helper method to invoke a method on the platform channel.
Future<void> _invokeMethod(String methodName, Map<String, dynamic> arguments,
    String errorMessage) async {
  const MethodChannel platform = MethodChannel('firebase_admob');
  try {
    await platform.invokeMethod(methodName, arguments);
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("$errorMessage: '${e.message}'");
    }
  }
}
