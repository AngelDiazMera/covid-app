import 'package:flutter/cupertino.dart';

class Symptom {
  int id;
  bool checked;
  String observation;

  Symptom({
    this.id,
    this.checked = false,
    this.observation,
  });
}
