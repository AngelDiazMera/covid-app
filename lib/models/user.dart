import 'package:flutter/cupertino.dart';

class User {
  int id;
  String name;
  String lastName;
  String email;
  String psw;
  bool isFemale;
  bool isDarkTheme;

  User({
    this.id,
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.psw,
    this.isFemale = false,
    this.isDarkTheme = false,
  });

  @override
  String toString() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'psw': psw,
      'isFemale': isFemale,
    }.toString();
  }
}
