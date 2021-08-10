import 'dart:async';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/pages/infected/widgets/checked_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';

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
  Future<Checked> getMyChecked() async {
    SharedPreferences prefs = await this.prefs;
    Checked newChecked = Checked(
      fever: prefs.getBool('fever') ?? false,
      dryCough: prefs.getBool('dry cough') ?? false,
      fatigue: prefs.getBool('fatigue') ?? false,
      soreThroat: prefs.getBool('sore throat') ?? false,
      diarrhoea: prefs.getBool('diarrhoea') ?? false,
      conjuctivitis: prefs.getBool('conjuctivitis') ?? false,
      headache: prefs.getBool('headache') ?? false,
      lossSenseOfSmell: prefs.getBool('loss of sense of smell') ?? false,
      lossColourInFingers: prefs.getBool('loss of colour in fingers') ?? false,
      difficultyBreathing: prefs.getBool('difficulty breathing') ?? false,
      chestPainOrPressure: prefs.getBool('chest pain or pressure') ?? false,
      inabilityToSpeak: prefs.getBool('inability to speak') ?? false,
    );
    return newChecked;
  }

  /// Saves an Check Symptom as a preference
  Future<bool> setChecked(String key, dynamic val) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool(key, val);
  }

  ///Symptoms
  Future<SymptomsUser> saveSymptom(SymptomsUser newSymptom) async {
    SharedPreferences prefs = await this.prefs;
    // prefs.setStringList('symptoms', newSymptom.symptoms.toList());
    prefs.setString('remarks', newSymptom.remarks);
    prefs.setString('symptomDate', newSymptom.symptomsDate.toString());

    ///prefs.setBool('isCovid', newSymptom.isCovid);
    ///prefs.setString('covidDate', newSymptom.covidDate.toString());
    print('Guardado Sintomas');
    return newSymptom;
  }

  Future<SymptomsUser> getMySymptom() async {
    SharedPreferences prefs = await this.prefs;
    SymptomsUser newSymptom = SymptomsUser(
      remarks: prefs.getString('remarks') ?? '',
      symptomsDate: DateTime.tryParse(prefs.getString('symptomDate')),

      ///isCovid: prefs.getBool('isCovid') ?? false,
      ///covidDate: DateTime.tryParse(prefs.getString('covidDate')),
    );
    print('REGRESANDO SINTOMAS: ${newSymptom}');
    return newSymptom;
  }
}
