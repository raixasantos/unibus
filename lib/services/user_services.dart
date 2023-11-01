import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibus/models/Aluno.dart';
import 'package:unibus/models/Motorista.dart';
import 'package:unibus/models/Usuario.dart';

class UserServices {
  /* deleta usuário */
  Future deleteUser(String name) async {
    QuerySnapshot queryResult = await FirebaseFirestore.instance
        .collection('users')
        .where('nome', isEqualTo: name)
        .get();
    queryResult.docs[0].reference.delete();
  }

  /* atualiza os dados do usuário */
  Future updateUser(Usuario user) async {
    if (user is Aluno) {
      QuerySnapshot queryResult = await FirebaseFirestore.instance
          .collection('users')
          .where('matricula', isEqualTo: user.matricula)
          .get();
      print(queryResult);
      queryResult.docs[0].reference.update({
        "nome": user.nome,
        "password": user.password,
        "faculdade": user.instituicao,
        "turno": user.turno
      });
    } else {
      Motorista motorista = user as Motorista;
      QuerySnapshot queryResult = await FirebaseFirestore.instance
          .collection('users')
          .where('numeroCarteira', isEqualTo: motorista.numeroCarteira)
          .get();
      queryResult.docs[0].reference.update({
        "nome": user.nome,
        "password": user.password,
      });
    }
  }
}
