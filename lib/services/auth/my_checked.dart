import 'package:persistencia_datos/pages/infected/widgets/checked_value.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

class MyChecked {
  static CheckedSymptoms _myChecked;
  static SymptomsUser _mySymptomsUser;
  static final MyChecked mine = MyChecked._();
  // Private constructor due to the singleton pattern
  MyChecked._();

  /// Get the Symptom of the app
  Future<CheckedSymptoms> getMyChecked() async {
    if (_myChecked != null) return _myChecked;
    return await Preferences.myPrefs.getMyChecked();
  }

  Future<SymptomsUser> getMyList() async {
    if (_mySymptomsUser.symptoms != null) return _mySymptomsUser;
  }
}
