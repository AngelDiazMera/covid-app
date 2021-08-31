import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:covserver/services/firebase/push_notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app.dart';

Future<void> main() async {
  // Ensure everything inits before drawing components
  WidgetsFlutterBinding.ensureInitialized();
  // Push notification service initialization
  await PushNotificationService.intitializeApp();
  // Alarm service init
  await AndroidAlarmManager.initialize();

  tz.initializeTimeZones();

  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}
