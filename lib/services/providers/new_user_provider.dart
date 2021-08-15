import 'package:flutter/material.dart';

class NewUserHandler with ChangeNotifier {
  bool _isNew = true;

  bool get isNew => _isNew;

  set isNew(bool isNew) {
    _isNew = isNew;
    notifyListeners();
  }
}
