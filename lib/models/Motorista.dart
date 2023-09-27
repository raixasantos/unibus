import 'package:unibus/models/Usuario.dart';

class Motorista extends Usuario{
  String _agenda;
  Motorista(super.nome, super._documento, this._agenda);
}