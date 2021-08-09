import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covserver/services/preferences/preferences.dart';

class Api {
  // Singleton structure
  static final Api _api = Api._internal();

  factory Api() {
    return _api;
  }

  /// Load the token from the preferences
  static Future<void> _loadToken() async {
    String token = await Preferences.myPrefs.getToken();
    _headers['Authorization'] = 'Bearer $token';
  }

  Api._internal();
  // Base url to make requests
  static String baseURL = 'http://192.168.100.22:5000';
  // Headers for the requests
  static Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': ''
  };

  /// custom POST method of http
  static Future<http.Response> post(String url,
      {Object? body, Encoding? encoding}) async {
    await _loadToken();
    return http.post(
      Uri.parse('$baseURL$url'),
      body: jsonEncode(body),
      headers: _headers,
      encoding: encoding,
    );
  }

  /// custom PUT method of http
  static Future<http.Response> put(String url,
      {Object? body, Encoding? encoding}) async {
    await _loadToken();
    return http.put(
      Uri.parse('$baseURL$url'),
      body: jsonEncode(body),
      headers: _headers,
      encoding: encoding,
    );
  }

  /// custom GET method of http
  static Future<http.Response> get(String url) async {
    await _loadToken();
    print(_headers);
    return http.get(Uri.parse('$baseURL$url'), headers: _headers);
  }
}
