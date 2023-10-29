import 'dart:io';

abstract class Usuario {
  String _nome;
  int _documento;
  String _password;

  Usuario(this._nome, this._documento, this._password);

  String get nome => _nome;
  int get documento => _documento;
  String get password => _password;
}
