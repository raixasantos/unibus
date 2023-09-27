import 'package:unibus/models/Usuario.dart';

class Aluno extends Usuario{
  String instituicao;
  String turno;
  Aluno(super.nome, super._documento, this.instituicao, this.turno);
}