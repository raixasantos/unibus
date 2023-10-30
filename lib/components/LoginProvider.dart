import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  String _name = '';
  String _senha = '';

  bool get isLogarEnabled {
    if (!_senha.isEmpty && !_name.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    print("Tem Nome");
    notifyListeners();
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
    print("Tem Senha");
    notifyListeners();
  }
}
