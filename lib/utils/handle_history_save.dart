import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/api/requests_symptom.dart';
import 'package:covserver/services/database/db.dart';
import 'package:covserver/utils/date_modifiers.dart';

Future<HistoryModel?> handleHistorySave(
    SymptomsUser symptomsUser, String status) async {
  var sympStr = '${symptomsUser.symptoms}';
  var tztime = getToday();

  HistoryModel history = new HistoryModel(
      time: tztime,
      status: status,
      symptoms: sympStr.substring(1, sympStr.length - 1));
  try {
    // api call
    bool res =
        await saveSymptoms(newSymptom: symptomsUser, healthCondition: status);
    if (!res) return null;
    // database register
    await DBProvider.db.newSymptomHistory(history);
    return history;
  } catch (e) {
    print(e);
  }
  return null;
}
