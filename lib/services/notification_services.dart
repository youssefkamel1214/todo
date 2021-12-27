import 'package:TODO/models/task.dart';
import 'package:TODO/ui/pages/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotifyHelper {
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  InitializationNotification() async
  {
  tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation(timeZoneName));
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('appicon');
final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,);
await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: (String?payload)async
    {
      selectNotification(payload!);
    });

  }
Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(payload: payload));
}
displayNotification({ required String title,required String body})async{
const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false);
 IOSNotificationDetails iosPlatformChannelSpecifics =
    IOSNotificationDetails();
 NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
    iOS:iosPlatformChannelSpecifics);
await flutterLocalNotificationsPlugin.show(
    0, title, body, platformChannelSpecifics,
    payload: 'defualt sound');

}

reaqurstpermission(){
      flutterLocalNotificationsPlugin.
      resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.
      requestPermissions(sound: true,alert: true,badge: true);
}
sculdauled_notification()async{
await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'scheduled title',
    'scheduled body',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    const NotificationDetails(
        android: AndroidNotificationDetails('your channel id'
          , 'your channel name', 'ay zft')
          ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

}
Future onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body!));
}
}
// final MacOSInitializationSettings initializationSettingsMacOS =
//     MacOSInitializationSettings();
