import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibus/constants/errors.dart';
import 'package:unibus/models/route_bus.dart';

class RouteServices {
  final CollectionReference routesCollection =
      FirebaseFirestore.instance.collection("routes");

  Future getRoutes() async {
    return await routesCollection.get();
  }

  Future getRoute(String name) async {
    return await routesCollection.where("name", isEqualTo: name).get();
  }

  Future<void> addRoute(RouteBus route) async {
    try {
      final existingRoute =
          await routesCollection.where('name', isEqualTo: route.name).get();

      if (existingRoute.docs.isEmpty) {
        await routesCollection.add(
          {
            'code_bus': route.codeBus,
            'description': route.description,
            'name': route.name
          },
        );
      } else {
        throw Exception(ErrorExists("A rota"));
      }
    } catch (e) {
      throw Exception(ErrorAdd("rota", e));
    }
  }

  Future<void> removeRoute(RouteBus route) async {
    print("Estou no service para excluir: ${route.name}");
    QuerySnapshot queryResult = await FirebaseFirestore.instance
        .collection('routes')
        .where('name', isEqualTo: route.name)
        .get();
    queryResult.docs[0].reference.delete();
  }

  Future<void> updateRoute(RouteBus route) async {
    QuerySnapshot queryResult = await FirebaseFirestore.instance
        .collection('routes')
        .where('code_bus', isEqualTo: route.codeBus)
        .get();
    print(queryResult);
    queryResult.docs[0].reference.update({
      "code_bus": route.codeBus,
      "name": route.name,
      "description": route.description,
    });
  }
}
