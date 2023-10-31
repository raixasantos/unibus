import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibus/models/Usuario.dart';

class UserServices{
  Future deleteUser(String name) async {
    QuerySnapshot queryResult = await FirebaseFirestore.instance.collection('users').where('nome', isEqualTo: name).get();
    queryResult.docs[0].reference.delete();
  }
}