import 'package:flutter/cupertino.dart';

class User {
  int id;
  String name;
  String lastName;
  String email;
  int group;
  double temperature;
  bool isFemale;
  bool isDarkTheme;

  User({
    this.id,
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.group,
    this.temperature,
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
      'group': group,
      'temperatu': temperature,
      'isFemale': isFemale,
    }.toString();
  }
}
