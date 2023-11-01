import 'package:flutter/material.dart';

class CadastroProvider with ChangeNotifier {
  String _name = '';
  String _senha = '';
  bool _isMotorista = false; // Alterado para _isMotorista
  int _matricula = 0;
  String _faculdade = '';
  String _turno = '';
  int _numeroCarteira = 0;

  bool get isCadastrarEnabled {
    if (_isMotorista) {
      return _name.isNotEmpty &&
          _senha.isNotEmpty &&
          _numeroCarteira > 0;
    } else {
      return _name.isNotEmpty &&
          _senha.isNotEmpty &&
          _matricula > 0 &&
          _faculdade.isNotEmpty &&
          _turno.isNotEmpty;
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

  bool get isMotorista => _isMotorista; // Alterado para isMotorista

  set isMotorista(bool value) {
    // Alterado para isMotorista
    _isMotorista = value;
    print("Motorista: $_isMotorista");
    notifyListeners();
  }

  int get matricula => _matricula;

  set matricula(int value) {
    _matricula = value;
    print("Tem matricula");
    notifyListeners();
  }

  String get faculdade => _faculdade;

  set faculdade(String value) {
    _faculdade = value;
    print("Tem faculdade");
    notifyListeners();
  }

  String get turno => _turno;

  set turno(String value) {
    _turno = value;
    print("Tem turno");
    notifyListeners();
  }

  int get numeroCarteira => _numeroCarteira;

  set numeroCarteira(int value) {
    _numeroCarteira = value;
    print("Tem carteira");
    notifyListeners();
  }
}
