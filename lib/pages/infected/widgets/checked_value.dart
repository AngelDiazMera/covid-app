import 'package:flutter/cupertino.dart';

class CheckedSymptoms {
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
  String nameFever;
  String nameDryCough;
  String nameFatigue;
  String namedifficultyBreathing;
  String namechestPainOrPressure;
  String nameinabilityToSpeak;
  String nameSoreThroat;
  String nameDiarrhoea;
  String nameConjuctivitis;
  String nameHeadache;
  String nameLossSenseOfSmell;
  String nameLossColourInFingers;

  CheckedSymptoms({
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
    this.nameFever = 'fever',
    this.nameDryCough = 'dry cough',
    this.nameFatigue = 'fatigue',
    this.namedifficultyBreathing = 'difficulty breathing',
    this.namechestPainOrPressure = 'chest pain or pressure',
    this.nameinabilityToSpeak = 'inability to speak',
    this.nameSoreThroat = 'sore throat',
    this.nameDiarrhoea = 'diarrhoea',
    this.nameConjuctivitis = 'conjuctivitis',
    this.nameHeadache = 'headache',
    this.nameLossSenseOfSmell = 'loss sense of smell',
    this.nameLossColourInFingers = 'loss colour in fingers',
  });
}
