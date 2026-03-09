import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:girlified/data/services/tflite_service.dart';

class ProtectionService {
  static final ProtectionService _instance = ProtectionService._internal();
  factory ProtectionService() => _instance;
  ProtectionService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _isProtectionActive = false;
  int _blockedCount = 0;
  int _scanCount = 0;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize notifications
    await _initializeNotifications();

    // Initialize background service
    await _initializeBackgroundService();

    // Load saved state
    await _loadState();

    _isInitialized = true;
  }

  Future<void> _initializeNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );

    // Create notification channel for Android
    const androidChannel = AndroidNotificationChannel(
      'saife_protection',
      'Girlified Protection',
      description: 'Notifications for blocked harmful content',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> _initializeBackgroundService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'saife_protection',
        initialNotificationTitle: 'Girlified',
        initialNotificationContent: 'Protection is active',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _isProtectionActive = prefs.getBool('protection_active') ?? false;
    _blockedCount = prefs.getInt('blocked_count') ?? 0;
    _scanCount = prefs.getInt('scan_count') ?? 0;
  }

  Future<void> startProtection() async {
    if (!_isInitialized) await initialize();

    _isProtectionActive = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('protection_active', true);

    // Start background service
    final service = FlutterBackgroundService();
    await service.startService();

    // Show notification
    await _showNotification(
      'Protection Active',
      'Girlified is now monitoring your apps',
      isOngoing: true,
    );
  }

  Future<void> stopProtection() async {
    _isProtectionActive = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('protection_active', false);

    // Stop background service
    final service = FlutterBackgroundService();
    service.invoke('stopService');

    // Cancel ongoing notification
    await _notificationsPlugin.cancel(888);
  }

  Future<void> onContentBlocked(String app, String category) async {
    _blockedCount++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('blocked_count', _blockedCount);

    // Show notification
    await _showNotification(
      'Harmful Content Blocked',
      'Blocked $category content in $app',
    );

    // Save to history
    await _saveToHistory(app, category);
  }

  Future<void> _saveToHistory(String app, String category) async {
    // TODO: Save to SQLite database
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('block_history') ?? [];
    history.add('${DateTime.now().toIso8601String()}|$app|$category');

    // Keep only last 100 entries
    if (history.length > 100) {
      history.removeRange(0, history.length - 100);
    }

    await prefs.setStringList('block_history', history);
  }

  Future<void> _showNotification(
    String title,
    String body, {
    bool isOngoing = false,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'saife_protection',
      'Girlified Protection',
      channelDescription: 'Notifications for blocked harmful content',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: isOngoing,
      autoCancel: !isOngoing,
      icon: '@mipmap/ic_launcher',
    );

    final iosDetails = DarwinNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      isOngoing ? 888 : DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  int get blockedCount => _blockedCount;
  int get scanCount => _scanCount;
  bool get isProtectionActive => _isProtectionActive;

  // Background service entry point
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    final tfliteService = TFLiteService();
    await tfliteService.initialize();

    // Listen for commands from Flutter app
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    service.on('updateProtection').listen((event) {
      // Update protection state
    });

    // Main monitoring loop
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          // Update foreground notification
          service.setForegroundNotificationInfo(
            title: 'Girlified Protection',
            content: 'Monitoring your apps...',
          );
        }
      }

      // Send heartbeat to Flutter app
      service.invoke('update', {
        'status': 'active',
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }
}
