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

Future<User> signIn(String email, String password) async {
  try {
    http.Response response = await Api.post('/user/signin', body: {
      'email': email,
      'password': password,
    });
    Map resMap = json.decode(response.body);
    print(resMap);

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
  } catch (error) {
    print(error);
    return null;
  }
  return null;
}
