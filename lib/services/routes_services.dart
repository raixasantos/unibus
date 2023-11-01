import 'package:cloud_firestore/cloud_firestore.dart';

class RouteServices {
  final String tablename = "routes";

  Future getRoute(int id) async {
    return await FirebaseFirestore.instance
        .collection(tablename)
        .where("id", isEqualTo: id)
        .get();
  }
}
