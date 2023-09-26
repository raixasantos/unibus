import 'dart:io';

abstract class Usuario{
  String _nome;
  File _documento;

  Usuario(this._nome, this._documento);
}