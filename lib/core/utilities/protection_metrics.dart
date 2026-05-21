import 'package:intl/intl.dart';
import 'package:girlified/core/providers/index.dart';

class ProtectionMetricsHelper {
  /// Logs when the digital safeguard status changes (active vs inactive)
  /// to accurately calculate today's cumulative protection time.
  static void logProtectionStateChange(bool isActive) {
    final now = DateTime.now();
    final storage = ServiceRegistry.localStorage;
    
    if (isActive) {
      storage.write('protection_enabled_at', now.toIso8601String());
    } else {
      final String? enabledAtStr = storage.read('protection_enabled_at');
      if (enabledAtStr != null) {
        final enabledAt = DateTime.parse(enabledAtStr);
        DateTime temp = enabledAt;
        
        // Handle spans across midnight(s)
        while (temp.day != now.day || temp.month != now.month || temp.year != now.year) {
          DateTime nextMidnight = DateTime(temp.year, temp.month, temp.day + 1);
          int secondsToMidnight = nextMidnight.difference(temp).inSeconds;
          final String currentDayKey = DateFormat('yyyy-MM-dd').format(temp);
          int daySeconds = storage.read('protection_daily_duration_seconds_$currentDayKey') ?? 0;
          storage.write('protection_daily_duration_seconds_$currentDayKey', daySeconds + secondsToMidnight);
          temp = nextMidnight;
        }
        
        final String todayKey = DateFormat('yyyy-MM-dd').format(now);
        int todaySeconds = storage.read('protection_daily_duration_seconds_$todayKey') ?? 0;
        storage.write('protection_daily_duration_seconds_$todayKey', todaySeconds + now.difference(temp).inSeconds);
      }
      storage.remove('protection_enabled_at');
    }
  }

  /// Calculates the cumulative protection active duration (in seconds) for a given day.
  /// If protection is currently running, it dynamically includes the elapsed time of the active session.
  static int getProtectionDurationForDay(DateTime day) {
    final String dateKey = DateFormat('yyyy-MM-dd').format(day);
    final storage = ServiceRegistry.localStorage;
    int seconds = storage.read('protection_daily_duration_seconds_$dateKey') ?? 0;
    
    final bool isActive = storage.read('protection_active') ?? false;
    final String? enabledAtStr = storage.read('protection_enabled_at');
    
    if (isActive && enabledAtStr != null) {
      final enabledAt = DateTime.parse(enabledAtStr);
      final now = DateTime.now();
      
      final startOfDay = DateTime(day.year, day.month, day.day);
      final endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59);
      
      if (enabledAt.isBefore(endOfDay) && now.isAfter(startOfDay)) {
        final intersectionStart = enabledAt.isAfter(startOfDay) ? enabledAt : startOfDay;
        final intersectionEnd = now.isBefore(endOfDay) ? now : endOfDay;
        
        final diff = intersectionEnd.difference(intersectionStart);
        if (diff.inSeconds > 0) {
          seconds += diff.inSeconds;
        }
      }
    }
    return seconds;
  }

  /// Seeds mock duration data for testing/demo purposes so that there is history.
  static void seedMockProtectionDurations() {
    final storage = ServiceRegistry.localStorage;
    if (storage.read('seeded_protection_metrics') == true) return;
    
    final now = DateTime.now();
    // Seed varying active protection hours for the last 7 days:
    // Today: 4.5h (16200s)
    // Yesterday: 1.5h (5400s)
    // 2 days ago: 8.0h (28800s)
    // 3 days ago: 0.5h (1800s)
    // 4 days ago: 10.0h (36000s)
    // 5 days ago: 5.0h (18000s)
    // 6 days ago: 12.0h (43200s)
    
    final mockHours = [4.5, 1.5, 8.0, 0.5, 10.0, 5.0, 12.0];
    for (int i = 0; i < mockHours.length; i++) {
      final dt = now.subtract(Duration(days: i));
      final String dateKey = DateFormat('yyyy-MM-dd').format(dt);
      final int seconds = (mockHours[i] * 3600).toInt();
      storage.write('protection_daily_duration_seconds_$dateKey', seconds);
    }
    
    // If protection is currently marked active, ensure we have an enabled_at timestamp set
    final bool isActive = storage.read('protection_active') ?? false;
    if (isActive && storage.read('protection_enabled_at') == null) {
      storage.write('protection_enabled_at', now.subtract(const Duration(hours: 2)).toIso8601String());
    }
    
    storage.write('seeded_protection_metrics', true);
  }
}
