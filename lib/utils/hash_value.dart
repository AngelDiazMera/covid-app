import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashValue(String value) {
  var bytes = utf8.encode(value); // data being hashed
  var digest = sha256.convert(bytes);
  return digest.toString();
}
