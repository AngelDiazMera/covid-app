import 'package:flutter/cupertino.dart';

class Checked {
  bool fever;
  bool dryCough;
  bool fatigue;
  bool soreThroat;
  bool diarrhoea;
  bool conjuctivitis;
  bool headache;
  bool lossSenseOfSmell;
  bool lossColourInFingers;
  bool difficultyBreathing;
  bool chestPainOrPressure;
  bool inabilityToSpeak;

  Checked({
    this.fever = false,
    this.dryCough = false,
    this.fatigue = false,
    this.soreThroat = false,
    this.diarrhoea = false,
    this.conjuctivitis = false,
    this.headache = false,
    this.lossSenseOfSmell = false,
    this.lossColourInFingers = false,
    this.difficultyBreathing = false,
    this.chestPainOrPressure = false,
    this.inabilityToSpeak = false,
  });
}
