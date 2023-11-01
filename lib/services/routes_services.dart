import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:unibus/utils/uuid.dart';

class RouteServices {
  final String tablename = "routes";

  Future getRoutes() async {
    return await FirebaseFirestore.instance.collection(tablename).get();
  }

  Future getRoute(int id) async {
    return await FirebaseFirestore.instance
        .collection(tablename)
        .where("id", isEqualTo: id)
        .get();
  }

  Future<void> addRoute(RouteBus route) async {
    String uuid = generateUUID();
    try {
      final CollectionReference routesCollection =
          FirebaseFirestore.instance.collection(tablename);

      final existingRoute =
          await routesCollection.where('name', isEqualTo: route.name).get();

      if (existingRoute.docs.isEmpty) {
        await routesCollection.add({
          'code_bus': route.codeBus,
          'description': route.description,
          'id': uuid,
          'name': route.name
        });
      } else {
        throw Exception('A rota já existe.');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar rota: $e');
    }
  }
}
