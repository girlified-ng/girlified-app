import 'package:flutter/services.dart';

class NativeService {
  static const MethodChannel _channel = MethodChannel('com.girlified.saife/native');
  static const EventChannel _eventChannel = EventChannel('com.girlified.saife/events');

  static final NativeService _instance = NativeService._internal();
  factory NativeService() => _instance;
  NativeService._internal();

  /// Check if Accessibility Service is enabled
  Future<bool> isAccessibilityServiceEnabled() async {
    try {
      final bool isEnabled = await _channel.invokeMethod('isAccessibilityServiceEnabled');
      return isEnabled;
    } catch (e) {
      print('Error checking accessibility service: $e');
      return false;
    }
  }

  /// Open Accessibility Settings
  Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } catch (e) {
      print('Error opening accessibility settings: $e');
    }
  }

  /// Check if Display Over Other Apps permission is granted
  Future<bool> canDrawOverlays() async {
    try {
      final bool canDraw = await _channel.invokeMethod('canDrawOverlays');
      return canDraw;
    } catch (e) {
      print('Error checking overlay permission: $e');
      return false;
    }
  }

  /// Request Display Over Other Apps permission
  Future<void> requestOverlayPermission() async {
    try {
      await _channel.invokeMethod('requestOverlayPermission');
    } catch (e) {
      print('Error requesting overlay permission: $e');
    }
  }

  /// Start the accessibility service
  Future<void> startAccessibilityService() async {
    try {
      await _channel.invokeMethod('startAccessibilityService');
    } catch (e) {
      print('Error starting accessibility service: $e');
    }
  }

  /// Stop the accessibility service
  Future<void> stopAccessibilityService() async {
    try {
      await _channel.invokeMethod('stopAccessibilityService');
    } catch (e) {
      print('Error stopping accessibility service: $e');
    }
  }

  /// Set protection state
  Future<void> setProtectionActive(bool active) async {
    try {
      await _channel.invokeMethod('setProtectionActive', {'active': active});
    } catch (e) {
      print('Error setting protection state: $e');
    }
  }

  /// Update sensitivity level
  Future<void> updateSensitivity(double level) async {
    try {
      await _channel.invokeMethod('updateSensitivity', {'level': level});
    } catch (e) {
      print('Error updating sensitivity: $e');
    }
  }

  /// Listen to events from native code
  Stream<Map<String, dynamic>> get nativeEvents {
    return _eventChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event as Map);
    });
  }

  /// Get statistics from native service
  Future<Map<String, int>> getStatistics() async {
    try {
      final Map<dynamic, dynamic> stats = await _channel.invokeMethod('getStatistics');
      return {
        'blockedCount': stats['blockedCount'] ?? 0,
        'scanCount': stats['scanCount'] ?? 0,
      };
    } catch (e) {
      print('Error getting statistics: $e');
      return {'blockedCount': 0, 'scanCount': 0};
    }
  }
}



