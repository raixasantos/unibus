import 'package:unibus/models/Usuario.dart';

class Aluno extends Usuario {
  String instituicao;
  String turno;
  int matricula;

  @override
  String toString() {
    return 'Aluno(nome: $nome, password: $password, instituição: $instituicao';
  }

  Aluno(
      String nome, String password, this.instituicao, this.turno, this.matricula, {imageUrl})
      : super(nome, password, imageUrl: imageUrl);
}
