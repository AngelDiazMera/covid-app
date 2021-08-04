import 'package:flutter/cupertino.dart';

class Symptom {
  int id;
  //String symptom;
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

  Symptom({
    this.id,
    //this.symptom,
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

  Map<String, bool> toJson() => {
        'fever': this.fever,
        'dry_cough': this.dryCough,
        'fatigue': this.fatigue,
        'sore_throat': this.soreThroat,
        'diarrhoea': this.diarrhoea,
        'conjuctivitis': this.conjuctivitis,
        'headache': this.headache,
        'loss_of_sense_of_smell': this.lossSenseOfSmell,
        'loss_of_colour_in_fingers': this.lossColourInFingers,
        'difficulty_breathing': this.difficultyBreathing,
        'chest_pain_or_pressure': this.chestPainOrPressure,
        'inability_to_speak': this.inabilityToSpeak,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
