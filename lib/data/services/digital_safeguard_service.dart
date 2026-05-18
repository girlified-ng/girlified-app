import 'package:flutter/services.dart';
import 'dart:io';

class DigitalSafeguardService {
  static const MethodChannel _channel = MethodChannel('com.saifeai.guardian/platform_bridge');

  /// Queries native APIs for active permission states.
  Future<Map<String, bool>> checkPermissionStatuses() async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod('checkPermissionStatuses');
      if (result != null) {
        return Map<String, bool>.from(result);
      }
    } on PlatformException catch (e) {
      print("Failed to check permissions: '${e.message}'.");
    }
    return {'vpn': false, 'accessibility': false, 'familyControls': false};
  }

  /// Requests platform-appropriate administrative permissions.
  Future<bool> requestNativePermissions(String permissionType) async {
    try {
      final bool result = await _channel.invokeMethod('requestNativePermissions', {'type': permissionType});
      return result;
    } on PlatformException catch (e) {
      print("Failed to request permission: '${e.message}'.");
    }
    return false;
  }

  /// Arms the local packet proxy and native UI monitors.
  Future<bool> startDigitalSafeguard(List<String> harassKeywords) async {
    try {
      final bool result = await _channel.invokeMethod('startDigitalSafeguard', {'keywords': harassKeywords});
      return result;
    } on PlatformException catch (e) {
      print("Failed to start safeguard: '${e.message}'.");
    }
    return false;
  }

  /// Tears down active network blocks and interface observers.
  Future<bool> stopDigitalSafeguard() async {
    try {
      final bool result = await _channel.invokeMethod('stopDigitalSafeguard');
      return result;
    } on PlatformException catch (e) {
      print("Failed to stop safeguard: '${e.message}'.");
    }
    return false;
  }
}
