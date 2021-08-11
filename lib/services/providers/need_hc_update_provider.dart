import 'package:flutter/material.dart';

class NeedHcUpdate with ChangeNotifier {
  bool _isUpdateNeeded = false;

  bool get isUpdateNeeded => _isUpdateNeeded;

  set isUpdateNeeded(bool isUpdateNeeded) {
    _isUpdateNeeded = isUpdateNeeded;
    notifyListeners();
  }
}
