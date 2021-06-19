import 'package:flutter/material.dart';

class Symptom {
  final int id;
  final String asset;
  final String name;
  final String description;

  Symptom(
      {this.id,
      @required this.asset,
      @required this.name,
      @required this.description});
}
