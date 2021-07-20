import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/api/requests.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

class MyUser {
  static User _myUser;
  static final MyUser mine = MyUser._();

  MyUser._();

  Future<User> getMyUser() async {
    if (_myUser != null) return _myUser;
    return await Preferences.myPrefs.getMyUser();
  }

  static void setTheme(bool dark) {
    Preferences.myPrefs.setTheme(dark);
    _myUser.isDarkTheme = dark;
  }

  static Future<bool> getTheme() async {
    return await Preferences.myPrefs.getTheme();
  }

  Future<void> saveMyUser(User newUser) async {
    User user = await signUp(newUser.name, newUser.lastName, newUser.isFemale,
        newUser.email, newUser.psw);
    print('Usuario guardado: $user');
    _myUser = await Preferences.myPrefs.saveUser(newUser);
  }
}
