import 'package:persistencia_datos/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences _prefs;
  static final Preferences myPrefs = Preferences._();
  Preferences._();

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs;
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  /// Saves an User as a preference
  Future<User> saveUser(User newUser) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString('name', newUser.name);
    prefs.setString('last_name', newUser.lastName);
    prefs.setString('email', newUser.email);
    prefs.setString('psw', newUser.psw);
    prefs.setString('gender', newUser.gender);
    print('Guardado');
    return newUser;
  }

  /// Set the theme configurations
  Future<bool> setTheme(bool dark) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool('is_dark_theme', dark);
    print('Tema cambiado');
    return dark;
  }

  /// Get the actual theme configurations
  Future<bool> getTheme() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getBool('is_dark_theme') ?? false;
  }

  /// Get an User as a preference
  Future<User> getMyUser() async {
    SharedPreferences prefs = await this.prefs;
    User newUser = User(
      name: prefs.getString('name') ?? '',
      lastName: prefs.getString('last_name') ?? '',
      email: prefs.getString('email') ?? '',
      psw: prefs.getString('psw') ?? '',
      gender: prefs.getString('gender') ?? 'male',
      isDarkTheme: prefs.getBool('is_dark_theme') ?? false,
    );
    print('REGRESANDO USUARIO: ${newUser}');
    return newUser;
  }

  ///Set the token of the session
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString('token', token);
  }

  /// Returns the token of the session
  Future<String> getToken() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getString('token') ?? '';
  }
}
