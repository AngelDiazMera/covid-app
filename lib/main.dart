import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:persistencia_datos/services/firebase/push_notification_service.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.intitializeApp();

  print('Se inicializó Flutter notifications');

  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}
