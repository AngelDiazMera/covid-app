import 'dart:convert';

import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/api/api.dart';
import 'package:http/http.dart' as http;

/// Save symtoms on server's database
Future<bool> saveSymptoms({
  required SymptomsUser newSymptom,
  /* AQUÍ PONES LOS ARGUMENTOS QUE NECESITES (PASA EL OBJETO O CADA VARIABLE INDIVIDUALMENTE) */
  Function? onError,
}) async {
  try {
    http.Response response = await Api.post('/symptoms/mine', body: {
      'symptoms': newSymptom.symptoms,
      'symptomsDate': newSymptom.symptomsDate,
      'remarks': newSymptom.remarks,
      'isCovid': newSymptom.isCovid,
      'covidDate': newSymptom.covidDate,
    }); // NOTA: AQUÍ PUEDES UTILIZAR TU MÉTODO TOJSON DEL OBJETO SYMPTOMS

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
