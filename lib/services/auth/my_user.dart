import 'package:covserver/models/user.dart';
import 'package:covserver/services/preferences/preferences.dart';

class MyUser {
  static User? _myUser;
  static final MyUser mine = MyUser._();
  // Private constructor due to the singleton pattern
  MyUser._();

  /// Get the logged user
  Future<User> getMyUser() async {
    if (_myUser != null) return MyUser._myUser!;
    _myUser = await Preferences.myPrefs.getMyUser();
    return _myUser!;
  }

  // Set the theme of the app
  static void setTheme(bool dark) {
    Preferences.myPrefs.setTheme(dark);
    _myUser!.isDarkTheme = dark;
  }

  /// Get the theme of the app
  static Future<bool> getTheme() async {
    return await Preferences.myPrefs.getTheme();
  }

  /// Save the user on the Preferences (used for sign in method)
  Future<User> savePrefs(User newUser) async {
    _myUser = await Preferences.myPrefs.saveUser(newUser);
    return _myUser!;
  }
}
