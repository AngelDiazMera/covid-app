import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/api/requests.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

class MyUser {
  static User _myUser;
  static final MyUser mine = MyUser._();
  // Private constructor due to the singleton pattern
  MyUser._();

  // Get the logged user
  Future<User> getMyUser() async {
    if (_myUser != null) return _myUser;
    return await Preferences.myPrefs.getMyUser();
  }

  // Set the theme of the app
  static void setTheme(bool dark) {
    Preferences.myPrefs.setTheme(dark);
    _myUser.isDarkTheme = dark;
  }

  // Get the theme of the app
  static Future<bool> getTheme() async {
    return await Preferences.myPrefs.getTheme();
  }

  Future<bool> saveMyUser(User newUser) async {
    // Signup an user by the api
    bool isRegistered = await signUp(newUser.name, newUser.lastName,
        newUser.isFemale, newUser.email, newUser.psw);

    if (isRegistered) {
      // Save data on preferences
      _myUser = await Preferences.myPrefs.saveUser(newUser);
      return true;
    }
    return false;
  }
}
