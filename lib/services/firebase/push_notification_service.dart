import 'dart:async';

import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  // Instance of firebase messaging
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  /// We use 'brodadcast' to prevent multiple subscriptions
  // String might be changed to Map to handle more than one data
  static StreamController<Map> _messageStream =
      new StreamController.broadcast();

  static Stream<Map> get messageStream => _messageStream.stream;

  /// Handles the local notifications plugin
  static FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();
  static FlutterLocalNotificationsPlugin get localNotification =>
      _localNotification;

  /// Handle the notification when it's running on background (not terminated)
  static Future _backgroundHandler(RemoteMessage message) async {
    // IMPORTANT: message.data contains a json with specific data
    // print('background handler: ${message.messageId}');
    // Recieves an string because is what we define, but it can be different
    // print(message);
    _messageStream.add(message.data);
  }

  /// Handle the notification when it comes and the app is open
  static Future _onMessageHandler(RemoteMessage message) async {
    // IMPORTANT: message.data contains a json with specific data
    // print('onMessageHandler handler: ${message.messageId}');
    // print(message);
    _messageStream.add(message.data);
  }

  /// Handle the notification when the client tap it
  static Future _onMessageOpenApp(RemoteMessage message) async {
    // IMPORTANT: message.data contains a json with specific data
    // print('onMessageOpenApp handler: ${message.messageId}');
    // print(message.data);
    // _messageStream.add(message.notification.title);
    // print(message);
    _messageStream.add(message.data);
  }

  static void fireDelayedNotification() async {
    await PushNotificationService._fireLocalNotification(
        title: '⏰ El periodo de riesgo ha finalizado🦠',
        body: 'Abra esta notificación para visualizar el cambio.',
        payload: 'time_finished');

    await Preferences.myPrefs.setNeedHCUpdate(true);
    // TODO: DElete next two lines
    // Add a prefference to handle alert_no_infection display
    // Preferences.myPrefs.setHealthCondition('healthy');
    // setHealthState('healthy');
  }

  static Future _fireLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
        'channelId', 'Local Notification', 'Some description',
        importance: Importance.high, priority: Priority.high);
    const iosDetails = IOSNotificationDetails();
    const generalDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await PushNotificationService.localNotification
        .show(0, title, body, generalDetails, payload: payload);
  }

  static Future intitializeApp() async {
    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token FCM: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local notifications
    const androidInit = AndroidInitializationSettings('ic_launcher');
    const iosInit = IOSInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    _localNotification.initialize(
      initSettings,
      onSelectNotification: notificationSelected,
    );
  }

  static Future notificationSelected(String? payload) async {
    print('SE ABRIÓ LA NOTIFICACIÓN');
    _messageStream.add({'type': payload});
  }

  /// Close the stream controller
  // Actually ,we never use this method because we always want
  // to be hearing the notifications, but to prevent warnings,
  // we write it
  static closeStreams() {
    print('CERRANDO STREAMS');
    _messageStream.close();
  }
}
