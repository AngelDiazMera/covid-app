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

  Future<bool> saveSymptoms(SymptomsUser newSymptom) async {
    _mySymptomsUser = await Preferences.myPrefs.saveSymptom(newSymptom);
    return true;
  }

  Future<bool> saveCovid(SymptomsUser newCovid) async {
    _mySymptomsUser = await Preferences.myPrefs.saveCovid(newCovid);
    return true;
  }

  void saveMySymptom(SymptomsUser newSymptom) {
    this._saveSymptom(newSymptom);
  }

  void _saveSymptom(SymptomsUser newSymptom) async {
    _mySymptomsUser = await Preferences.myPrefs.saveSymptom(newSymptom);
  }

  void saveMyCovid(SymptomsUser newCovid) {
    this._saveCovid(newCovid);
  }

  void _saveCovid(SymptomsUser newCovid) async {
    _mySymptomsUser = await Preferences.myPrefs.saveCovid(newCovid);
  }
}
