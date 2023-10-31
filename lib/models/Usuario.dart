import 'dart:io';

abstract class Usuario {
  String _nome;
  String _password;

  Usuario(this._nome, this._password);

  String get nome => _nome;
  String get password => _password;

  set nome(String nome){
    _nome = nome;
  }
}
