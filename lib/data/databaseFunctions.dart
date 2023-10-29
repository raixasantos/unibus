import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFunctions {
  static Future createUser(Map<String, dynamic> userInfo) async {
    return await FirebaseFirestore.instance.collection('users').doc().set(userInfo);
  }
}