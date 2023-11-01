import 'package:cloud_firestore/cloud_firestore.dart';

class BusServices {
  final String tablename = "bus";

  Future getBus(int id) async {
    return await FirebaseFirestore.instance
        .collection(tablename)
        .where("id", isEqualTo: id)
        .get();
  }
}
