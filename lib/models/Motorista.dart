import 'package:unibus/models/Usuario.dart';

class Motorista extends Usuario {
  int _numeroCarteira;

  Motorista(String nome, String password, this._numeroCarteira)
      : super(nome, password);

  set numeroCarteira(int numeroCarteira) {
    _numeroCarteira = numeroCarteira;
  }
  int get numeroCarteira => _numeroCarteira;

  @override
  String toString() {
    return 'Motorista(nome: $nome, password: $password, numeroCarteira: $_numeroCarteira)';
  }
}
