import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUser {
  static User _myUser;

  static final MyUser mine = MyUser._();

  MyUser._();

  Future<User> getMyUser() async {
    if (_myUser != null) return _myUser;
    return await Preferences.myPrefs.getMyUser();
  }

  void saveMyUser(User newUser) {
    this._save(newUser);
  }

  static void setTheme(bool dark) {
    Preferences.myPrefs.setTheme(dark);
    _myUser.isDarkTheme = dark;
  }

  static Future<bool> getTheme() async {
    return await Preferences.myPrefs.getTheme();
  }

  void _save(User newUser) async {
    _myUser = await Preferences.myPrefs.saveUser(newUser);
  }
}
