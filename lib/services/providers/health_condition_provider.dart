import 'package:flutter/cupertino.dart';

class HealthCondition with ChangeNotifier {
  Map<String, String> _parser = {
    'healthy': 'Sin riesgo',
    'risk': 'En riesgo',
    'infected': 'Contagiado',
  };

  String _healthCondition = 'healthy';

  String get healthCondition {
    return _parser[_healthCondition] ?? 'Sin riesgo';
  }

  String get notParsed => _healthCondition;

  set healthCondition(String hc) {
    _healthCondition = hc;
    notifyListeners();
  }
}
