import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings("logo");

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void schedule(
  String title,
  String body,
  DateTime scheduledNotificationDateTime,
) async {
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails('channelId', 'channelName',
          icon: 'logo',
          largeIcon: DrawableResourceAndroidBitmap('logo'),
          importance: Importance.max,
          // playSound: false,
          sound: RawResourceAndroidNotificationSound("notification"),
          priority: Priority.high);
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await _flutterLocalNotificationsPlugin.schedule(
    0,
    title,
    body,
    scheduledNotificationDateTime,
    notificationDetails,
  );
}

}
