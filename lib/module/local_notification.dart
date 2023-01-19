// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:money_expance/utilies/constant.dart';
//
// class LocalNotification {
//   static init() {
//     AwesomeNotifications().initialize(null, // icon for your app notification
//         [
//           NotificationChannel(
//             channelKey: 'key1',
//             channelName: 'Proto Coders Point',
//             channelDescription: "Notification example",
//             defaultColor: AppColors.black50,
//             ledColor: AppColors.lite20,
//             playSound: true,
//             enableLights: true,
//             enableVibration: true,
//             importance: NotificationImportance.Max,
//           )
//         ]);
//   }
//
//   static createNotification() async {
//     String timeZon = await AwesomeNotifications().getLocalTimeZoneIdentifier();
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 1,
//           category: NotificationCategory.Reminder,
//           channelKey: 'key1',
//           title: 'This is Notification title',
//           body: 'This is Body of Note',
//           bigPicture:
//               'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
//           notificationLayout: NotificationLayout.BigPicture,
//           wakeUpScreen: true,
//         ),
//         schedule: NotificationCalendar(
//           timeZone: timeZon,
//           repeats: true,
//           minute: 0,
//           day: 16,
//           hour: 03,
//           month: 01,
//           year: 2023,
//         ));
//   }
// }
