import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/database/db.dart';

Future<HistoryModel?> handleHistorySave(
    SymptomsUser symptomsUser, String status) async {
  var sympStr = '${symptomsUser.symptoms}';
  var time = DateTime.now();
  HistoryModel history = new HistoryModel(
      time: time,
      status: status,
      symptoms: sympStr.substring(1, sympStr.length - 1));
  try {
    await DBProvider.db.newSymptomHistory(history);
    // TODO: AGREGAR REGISTRO EN API
    return history;
  } catch (e) {
    print(e);
  }
  return null;
}
