import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/firebase/push_notification_service.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:flutter/material.dart';

/// Handle the tap action of a user into the button 'Estoy en riesgo'.
/// It starts an alarm which makes a shot after 14 days, updates
/// the preferences and send a reques to to the api to handle the
/// current health condition of the user.
void handleNotificationRisk(BuildContext context, HealthCondition hc) async {
  int _alarmId = 0;
  // cancel previous alarm
  bool cancel = await AndroidAlarmManager.cancel(_alarmId);
  if (cancel) print('Se canceló la alarma anterior');
  // Dates to handle 14 dyas
  DateTime today = DateTime.now();
  DateTime later = today.add(Duration(seconds: 5));
  // Start the alarm
  AndroidAlarmManager.oneShotAt(
      later, _alarmId, PushNotificationService.fireDelayedNotification);
  print('Se estableció una nueva alarma que sonará el día $later');
  // Api request to update healthState
  Map<dynamic, dynamic>? res = await setHealthState('risk');
  // If everything's ok
  if (res != null) {
    Preferences.myPrefs.setHealthCondition('risk');
    hc.healthCondition = 'risk';
    print('Se ha cambiado la salud a ${hc.healthCondition}');
  }
}
