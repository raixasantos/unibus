import 'dart:io';

abstract class Usuario {
  String _nome;
  String _password;
  File? _imageUrl; // Adicionado

  Usuario(this._nome, this._password, {File? imageUrl})
      : _imageUrl = imageUrl; // Adicionado

  set password(String senha) {
    _password = senha;
  }

  String get nome => _nome;
  String get password => _password;
  File? get imageUrl => _imageUrl;

  set imageUrl(File? file) {
    _imageUrl = file;
  }

  set nome(String nome) {
    _nome = nome;
  }
}
