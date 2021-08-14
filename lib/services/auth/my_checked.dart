import 'package:covserver/pages/infected/widgets/checked_value.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/preferences/preferences.dart';

class MyChecked {
  static CheckedSymptoms? _myChecked;
  static SymptomsUser? _mySymptomsUser;
  static final MyChecked mine = MyChecked._();
  // Private constructor due to the singleton pattern
  MyChecked._();

  /// Get the Symptom of the app
  Future<CheckedSymptoms> getMyChecked() async {
    if (_myChecked != null) return _myChecked!;
    return await Preferences.myPrefs.getMyChecked();
  }

  Future<SymptomsUser?> getMyList() async {
    if (_mySymptomsUser?.symptoms != null) return _mySymptomsUser!;
    return null;
  }
}
