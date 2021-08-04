import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/models/symptom_register.dart';
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

  ///Get an Symptom as a preference
  Future<Symptom> getMySymptom() async {
    SharedPreferences prefs = await this.prefs;
    Symptom newSymptom = Symptom(
      //symptom: prefs.getString('symptom') ?? '',
      fever: prefs.getBool('fever') ?? false,
      dryCough: prefs.getBool('dry_cough') ?? false,
      fatigue: prefs.getBool('fatigue') ?? false,
      soreThroat: prefs.getBool('sore_throat') ?? false,
      diarrhoea: prefs.getBool('diarrhoea') ?? false,
      conjuctivitis: prefs.getBool('conjuctivitis') ?? false,
      headache: prefs.getBool('headache') ?? false,
      lossSenseOfSmell: prefs.getBool('loss_of_sense_of_smell') ?? false,
      lossColourInFingers: prefs.getBool('loss_of_colour_in_fingers') ?? false,
      difficultyBreathing: prefs.getBool('difficulty_breathing') ?? false,
      chestPainOrPressure: prefs.getBool('chest_pain_or_pressure') ?? false,
      inabilityToSpeak: prefs.getBool('inability_to_speak') ?? false,
    );
    print('REGRESANDO SINTOMAS: ${newSymptom}');
    return newSymptom;
  }

  /// Saves an Check Symptom as a preference
  Future<bool> setSymptom(String key, dynamic val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  /// Saves an Symptom as a preference
  Future<Symptom> saveSymptom(Symptom newSymptom) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool('fever', newSymptom.fever);
    prefs.setBool('dry_cough', newSymptom.dryCough);
    prefs.setBool('fatigue', newSymptom.fatigue);
    prefs.setBool('sore_throat', newSymptom.soreThroat);
    prefs.setBool('diarrhoea', newSymptom.diarrhoea);
    prefs.setBool('conjuctivitis', newSymptom.conjuctivitis);
    prefs.setBool('headache', newSymptom.headache);
    prefs.setBool('loss_of_sense_of_smell', newSymptom.lossSenseOfSmell);
    prefs.setBool('loss_of_colour_in_fingers', newSymptom.lossColourInFingers);
    prefs.setBool('difficulty_breathing', newSymptom.difficultyBreathing);
    prefs.setBool('chest_pain_or_pressure', newSymptom.chestPainOrPressure);
    prefs.setBool('inability_to_speak', newSymptom.inabilityToSpeak);
    print('Guardado');
    return newSymptom;
  }
}
