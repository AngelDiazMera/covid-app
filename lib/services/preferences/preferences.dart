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

  Future<User> saveUser(User newUser) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString('name', newUser.name);
    prefs.setString('last_name', newUser.lastName);
    prefs.setString('email', newUser.email);
    prefs.setString('psw', newUser.psw);
    prefs.setBool('isFemale', newUser.isFemale);
    print('Guardado');
    return newUser;
  }

  Future<bool> setTheme(bool dark) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool('is_dark_theme', dark);
    print('Tema cambiado');
    return dark;
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getBool('is_dark_theme') ?? false;
  }

  Future<User> getMyUser() async {
    SharedPreferences prefs = await this.prefs;
    User newUser = User(
      name: prefs.getString('name') ?? '',
      lastName: prefs.getString('last_name') ?? '',
      email: prefs.getString('email') ?? '',
      psw: prefs.getString('psw') ?? '',
      isFemale: prefs.getBool('isFemale') ?? false,
      isDarkTheme: prefs.getBool('is_dark_theme') ?? false,
    );
    print('REGRESANDO USUARIO: ${newUser}');
    return newUser;
  }
}
