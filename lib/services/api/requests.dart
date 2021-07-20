import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/api/api.dart';

Future<User> signUp(String name, String lastName, bool isFamale, String email,
    String psw) async {
  Map<String, dynamic> requestPayload = {
    "name": name,
    "lastName": lastName,
    "isFamale": isFamale,
    "access": {"email": email, "password": psw}
  };

  final http.Response response = await Api.post('/user', body: requestPayload);

  if (response.statusCode == 200)
    return User.fromJson(json.decode(response.body));

  return null;
}
