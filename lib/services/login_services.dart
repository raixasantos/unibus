import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginServices {
  Future getUser(String name, String password) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("nome", isEqualTo: name)
        .where("password", isEqualTo: password)
        .get();
  }
}
