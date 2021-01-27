import 'package:flutter/material.dart';

class NotifyProvider with ChangeNotifier {
  String _message = '';

  get message {
    return this._message;
  }

  set message(String message) {
    this._message = message;
    notifyListeners();
  }
}
