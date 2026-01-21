import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzData.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(settings);
  }

  static Future<void> sendTestNotification() async {
    await _notifications.show(
      99, // id
      'Test Notification',
      'This is a test push from CodeMaze!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Channel',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }

  static Future<void> scheduleDailyReminder() async {
    await _notifications.zonedSchedule(
      0,
      'Daily Challenge Reminder',
      'Don’t forget to complete your CodeMaze challenge today!',
      _nextInstanceOf8AM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Daily at same time
    );
  }

  static Future<void> cancelDailyReminder() async {
    await _notifications.cancel(0); // ID must match scheduled one
  }

  static tz.TZDateTime _nextInstanceOf8AM() {
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 8); // 8 AM
    return now.isBefore(scheduled)
        ? scheduled
        : scheduled.add(const Duration(days: 1));
  }
}
