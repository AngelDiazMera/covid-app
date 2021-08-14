import 'dart:async';

import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/pages/infected/widgets/checked_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefs;
  static final Preferences myPrefs = Preferences._();
  Preferences._();

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return Preferences._prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Saves an User as a preference
  Future<User> saveUser(User newUser) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString('name', newUser.name!);
    prefs.setString('last_name', newUser.lastName!);
    prefs.setString('email', newUser.email!);
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
    print('REGRESANDO USUARIO: $newUser');
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

  /// Returns the health condition of the user
  Future<String> getHealthCondition() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getString('healthCondition') ?? 'healthy';
  }

  /// Sets the health condition of the user.
  /// `healthCondition` must be one of these values `'healthy', 'risk', 'infected'`
  Future<void> setHealthCondition(String healthCondition) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setString('healthCondition', healthCondition);
  }

  /// Returns the necesity of update the health condition (when alarm ends)
  Future<bool> getNeedHCUpdate() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getBool('needHCUpdate') ?? false;
  }

  /// Set true if alarm detected to update health state
  Future<void> setNeedHCUpdate(bool isNeeded) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool('needHCUpdate', isNeeded);
  }

  ///Get an Symptom as a preference
  Future<CheckedSymptoms> getMyChecked() async {
    SharedPreferences prefs = await this.prefs;
    CheckedSymptoms newChecked = CheckedSymptoms(
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
  Future<void> setChecked(String key, dynamic val) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool(key, val);
  }

  /// Saves an Symptom User as a preference
  Future<SymptomsUser> saveSymptom(SymptomsUser newSymptom) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setStringList('symptoms', newSymptom.symptoms);
    prefs.setString('remarks', newSymptom.remarks);
    prefs.setString('symptomsDate', newSymptom.symptomsDate.toString());
    print('Guardado Sintomas');
    return newSymptom;
  }

  /// Get an Symptom User as a preference
  Future<SymptomsUser> getMySymptom() async {
    SharedPreferences prefs = await this.prefs;
    SymptomsUser newSymptom = SymptomsUser(
      symptoms: prefs.getStringList('symptoms') ?? [],
      remarks: prefs.getString('remarks') ?? '',
      symptomsDate: DateTime.tryParse(prefs.getString('symptomsDate') ?? ''),
      isCovid: prefs.getBool('isCovid') ?? false,
      covidDate: DateTime.tryParse(prefs.getString('covidDate') ?? ''),
    );
    print('REGRESANDO SINTOMAS: $newSymptom');
    return newSymptom;
  }

  /// Saves an Covid User as a preference
  Future<SymptomsUser> saveCovid(SymptomsUser newCovid) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool('isCovid', newCovid.isCovid);
    prefs.setString('covidDate', newCovid.covidDate.toString());
    print('Guardado Covid');
    return newCovid;
  }
}
