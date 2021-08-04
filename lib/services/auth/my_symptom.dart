import 'package:persistencia_datos/models/symptom_register.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

class MySymtop {
  static Symptom _mySymptom;
  static final MySymtop mine = MySymtop._();
  // Private constructor due to the singleton pattern
  MySymtop._();

  /// Get the Symptom of the app
  Future<Symptom> getMySymptom() async {
    if (_mySymptom != null) return _mySymptom;
    return await Preferences.myPrefs.getMySymptom();
  }

  /// Save the Symptom on the Preferences (used for sign in method)
  Future<Symptom> savePrefs(Symptom newSymptom) async {
    return await Preferences.myPrefs.saveSymptom(newSymptom);
  }
}
