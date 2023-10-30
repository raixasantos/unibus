import 'package:unibus/models/Usuario.dart';

class Aluno extends Usuario {
  String instituicao;
  String turno;

  @override
  String toString() {
    return 'Motorista(nome: $nome, password: $password, instituição: $instituicao';
  }

  Aluno(
      String nome, int documento, String password, this.instituicao, this.turno)
      : super(nome, password);
}
