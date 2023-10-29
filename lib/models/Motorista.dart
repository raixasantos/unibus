import 'package:unibus/models/Usuario.dart';

class Motorista extends Usuario {
  String _agenda;

  Motorista(String nome, int documento, String password, this._agenda)
      : super(nome, documento, password);

  @override
  String toString() {
    return 'Motorista(nome: $nome, documento: $documento, password: $password, agenda: $_agenda)';
  }
}
