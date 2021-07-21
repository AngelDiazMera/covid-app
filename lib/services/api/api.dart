import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static final Api _api = Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();

  static String baseURL = 'http://192.168.100.18:5000';

  static Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': 'Bearer <Your token>'
  };

  static Future<http.Response> post(String url,
      {Object body, Encoding encoding}) {
    return http.post(
      Uri.parse('$baseURL$url'),
      body: jsonEncode(body),
      headers: _headers,
      encoding: encoding,
    );
  }

  static Future<http.Response> get(Uri url) {
    return http.get(url);
  }
}
