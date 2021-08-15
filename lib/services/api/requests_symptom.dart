import 'dart:convert';

import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/api/api.dart';
import 'package:http/http.dart' as http;

/// Save symtoms on server's database
Future<bool> saveSymptoms({
  required SymptomsUser newSymptom,
  required String healthCondition,
  Function? onError,
}) async {
  try {
    Map body = {
      'symptoms': newSymptom.symptoms,
      'symptomsDate': newSymptom.symptomsDate?.toUtc().toString(),
      'remarks': newSymptom.remarks,
      'isCovid': newSymptom.isCovid,
      'covidDate': newSymptom.covidDate?.toUtc().toString(),
      'healthCondition': healthCondition,
    };
    print(body);
    http.Response response = await Api.post('/symptoms/mine', body: body);

    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) return true;

    // Otherwise, onError will be called
    if (onError != null) onError(json.decode(response.body)['msg']);
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor: $error');
  }
  return false;
}

/// Save symtoms on server's database
Future<bool> deleteSymptoms({
  Function? onError,
}) async {
  try {
    http.Response response = await Api.delete('/symptoms/mine');

    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) return true;

    // Otherwise, onError will be called
    if (onError != null) onError(json.decode(response.body)['msg']);
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor: $error');
  }
  return false;
}
