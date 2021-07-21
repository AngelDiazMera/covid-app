import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/api/api.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

Future<bool> signUp(User newUser) async {
  try {
    final http.Response response =
        await Api.post('/user/signup', body: newUser.toJson());
    if (response.statusCode == 200) return true;
  } catch (error) {
    print(error);
    return false;
  }
  // return User.fromJson(json.decode(response.body));
  return false;
}

/// Sign an user with email and password
/// Once is signed, returns the user
/// Also, when user is signed, the Bearer token is saved on the preferences
/// If something goes wrong, the return will be null and the callback
///  onError will be excecuted
Future<User> signIn(String email, String password, {Function onError}) async {
  try {
    http.Response response = await Api.post('/user/signin', body: {
      'email': email,
      'password': password,
    });
    Map resMap = json.decode(response.body);
    print(resMap);
    // When the user logged successfully
    if (response.statusCode == 200) {
      User newUser = User(
        name: resMap['user']['name'],
        lastName: resMap['user']['lastName'],
        gender: resMap['user']['gender'],
        email: resMap['user']['email'],
      );
      Preferences.myPrefs.setToken(resMap['token']);
      return newUser;
    }
    // Otherwise, onError will be called
    if (onError != null) {
      onError(json.decode(response.body)['msg']);
      return null;
    }
  } catch (error) {
    if (onError != null) onError('Ocurrió un problema con el servidor');
    return null;
  }
  return null;
}
