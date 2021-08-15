import 'dart:async';

import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/pages/symptoms/widgets/checked_value.dart';
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

  Future<List<String>> getSymptoms() async {
    SharedPreferences prefs = await this.prefs;
    return prefs.getStringList('symptoms') ?? [];
  }

  Future<void> setSymptoms(List<String> symptoms,
      {String? remarks, String? symptomsDate}) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setStringList('symptoms', symptoms);
    prefs.setString('symptomsDate', symptomsDate ?? '');
    prefs.setString('remarks', remarks ?? '');
    prefs.setBool('isCovid', false);
    prefs.remove('covidDate');
  }

  Future<void> setCovid(bool isCovid, String covidDate) async {
    SharedPreferences prefs = await this.prefs;
    prefs.setBool('isCovid', isCovid);
    prefs.setString('covidDate', covidDate);
    prefs.setString('healthCondition', 'infected');
  }

  Future<void> deleteCovid() async {
    SharedPreferences prefs = await this.prefs;
    prefs.remove('isCovid');
    prefs.remove('covidDate');
    prefs.remove('symptomsDate');
    prefs.remove('remarks');
    prefs.setString('healthCondition', 'healthy');
  }
}
