import 'package:unibus/models/Usuario.dart';

class Aluno extends Usuario {
  String instituicao;
  String turno;

  set senha(String senha) {}

  set faculdade(String faculdade) {}

  set matricula(String matricula) {}

  @override
  String toString() {
    return 'Aluno(nome: $nome, password: $password, instituição: $instituicao';
  }

  Aluno(
      String nome, int documento, String password, this.instituicao, this.turno)
      : super(nome, password);
}
