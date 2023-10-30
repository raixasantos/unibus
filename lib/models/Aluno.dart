import 'package:unibus/models/Usuario.dart';

class Aluno extends Usuario {
  String instituicao;
  String turno;

  Aluno(
      String nome, int documento, String password, this.instituicao, this.turno)
      : super(nome, password);
}
