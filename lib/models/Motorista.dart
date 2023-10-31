import 'package:unibus/models/Usuario.dart';

class Motorista extends Usuario {
  String _numeroCarteira;

  Motorista(String nome, String password, this._numeroCarteira)
      : super(nome, password);

  set numeroCarteira(String numeroCarteira) {
    _numeroCarteira = numeroCarteira;
  }

  set password (String senha){
    password = senha;
  }

  @override
  String toString() {
    return 'Motorista(nome: $nome, password: $password, numeroCarteira: $_numeroCarteira)';
  }
}
