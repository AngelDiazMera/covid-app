// MD5: 1A:1D:EB:4C:83:C6:5A:BF:CA:57:84:3D:CF:39:E6:9A
// SHA1: 00:D1:B2:BD:A8:C0:AB:29:34:91:36:CC:46:BD:61:20:DA:69:FD:BC
// SHA-256: A7:1E:CE:2F:DE:52:80:59:DC:D7:57:C2:7C:7A:FC:43:0A:4A:63:0C:FB:DD:5F:1B:9A:A9:E4:BD:95:E9:6D:F3

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  // Instance of firebase messaging
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String token;

  /// We use 'brodadcast' to prevent multiple subscriptions
  // String might be changed to Map to handle more than one data
  static StreamController<Map> _messageStream =
      new StreamController.broadcast();
  static Stream<Map> get messageStream => _messageStream.stream;

  /// Handle the notification when it's running on background (not terminated)
  static Future _backgroundHandler(RemoteMessage message) async {
    // IMPORTANT: message.data contains a json with specific data
    // print('background handler: ${message.messageId}');
    // Recieves an string because is what we define, but it can be different
    // print(message.data);
    _messageStream.add(message.data ?? {'msg': 'No data'});
  }

  /// Handle the notification when it comes and the app is open
  static Future _onMessageHandler(RemoteMessage message) async {
    // IMPORTANT: message.data contains a json with specific data
    // print('onMessageHandler handler: ${message.messageId}');
    // print(message.data);
    _messageStream.add(message.data ?? {'msg': 'No data'});
  }

  /// Handle the notification when the client tap it
  static Future _onMessageOpenApp(RemoteMessage message) async {
    // IMPORTANT: message.data contains a json with specific data
    // print('onMessageOpenApp handler: ${message.messageId}');
    // print(message.data);
    // _messageStream.add(message.notification.title);
    _messageStream.add(message.data ?? {'msg': 'No data'});
  }

  static Future intitializeApp() async {
    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken() ?? '';
    print('Token flutter: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local notifications
  }

  /// Close the stream controller
  // Actually ,we never use this method because we always want
  // to be hearing the notifications, but to prevent warnings,
  // we write it
  static closeStreams() {
    _messageStream.close();
  }
}
