import 'package:flutter/cupertino.dart';

class User {
  int id;
  String name;
  String lastName;
  String email;
  String psw;
  String gender;
  bool isDarkTheme;

  User({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.psw,
    this.gender = 'male',
    this.isDarkTheme = false,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        lastName: json['lastName'],
        gender: json['gender'],
        email: json['email'],
        psw: json['password']);
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'lastName': this.lastName,
        'gender': this.gender,
        'access': {'email': this.email, 'password': this.psw},
      };

  /*@override
  String toString() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'psw': psw,
      'gender': gender,
    }.toString();
  }*/
}
