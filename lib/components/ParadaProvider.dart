import 'package:flutter/material.dart';

class ParadaProvider with ChangeNotifier {
  String _nome = '';
  String _rua = '';
  String _bairro = '';
  int _numero = 0;
  double _lat = 0;
  double _long = 0;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
    print("Tem Nome");
    notifyListeners();
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
    print("Tem Bairro");
    notifyListeners();
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
    print("Tem Rua");
    notifyListeners();
  }

  int get numero => _numero;

  set numero(int value) {
    _numero = value;
    print("Tem Numero");
    notifyListeners();
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
    print("Tem Latitude");
    notifyListeners();
  }

  double get long => _long;

  set long(double value) {
    _long = value;
    print("Tem Rua");
    notifyListeners();
  }
}
