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
        "turno": user.turno,
        "imageUrl": user.imageUrl?.path,
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
        "imageUrl": user.imageUrl?.path,
      });
    }
  }

  /* cria usuários no banco */
  Future CreateUser(Usuario user) async {
    Map<String, dynamic> userMapping = {};
    if (user is Aluno) {
      userMapping = {
        "nome": user.nome,
        "matricula": user.matricula,
        "faculdade": user.instituicao,
        "password": user.password,
        "turno": user.turno,
        "numeroCarteira": 0,
        "imageUrl": user.imageUrl?.path,
      };
    } else if (user is Motorista) {
      userMapping = {
        "nome": user.nome,
        "password": user.password,
        "numeroCarteira": user.numeroCarteira,
        "imageUrl": user.imageUrl?.path,
      };
    }
    final users = await FirebaseFirestore.instance.collection('users').doc();
    users.set(userMapping);
  }
}
