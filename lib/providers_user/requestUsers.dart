import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:persistencia_datos/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class request {
  Future<User> userRegister(String name, String lastName, bool isFamale,
      String email, String psw) async {
    const url = "http://192.168.0.107:5000/user";
    Map<String, dynamic> requestPayload = {
      "name": name,
      "lastName": lastName,
      "isFamale": isFamale,
      "access": {"email": email, "password": psw}
    };

    final http.Response response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestPayload));
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    }
  }
}
