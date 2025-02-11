// lib/state/app_state.dart
import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  bool _radioIsLive = false;

  bool get radioIsLive => _radioIsLive;

  void toggleRadioLive() {
    _radioIsLive = !_radioIsLive;
    notifyListeners();
  }
}
