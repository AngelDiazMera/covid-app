import 'package:covserver/models/history_model.dart';
import 'package:flutter/cupertino.dart';

class HistoryProvider with ChangeNotifier {
  List<HistoryModel> history = [];

  void addRegister(HistoryModel register) {
    history.add(register);
    notifyListeners();
  }
}
