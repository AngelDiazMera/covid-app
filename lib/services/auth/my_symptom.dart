import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

class MySymptom {
  static SymptomsUser _mySymptomsUser;
  static final MySymptom mine = MySymptom._();

  MySymptom._();

  Future<SymptomsUser> getMySymptom() async {
    if (_mySymptomsUser != null) return _mySymptomsUser;
    return await Preferences.myPrefs.getMySymptom();
  }

  void saveMySymptom(SymptomsUser newSymptom) {
    this._save(newSymptom);
  }

  void _save(SymptomsUser newSymptom) async {
    _mySymptomsUser = await Preferences.myPrefs.saveSymptom(newSymptom);
  }
}
