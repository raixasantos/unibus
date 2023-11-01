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
    try {
      final routeDocument = await routesCollection.doc(route.name).get();

      if (routeDocument.exists) {
        await routesCollection.doc(route.name).delete();
      } else {
        throw Exception(ErrorNotExists('A rota'));
      }
    } catch (e) {
      throw Exception(ErrorRemove("rota", e));
    }
  }

  Future<void> updateRoute(RouteBus route) async {
    try {
      final existingRoute =
          await routesCollection.where('name', isEqualTo: route.name).get();

      if (existingRoute.docs.isNotEmpty) {
        final docId = existingRoute.docs[0].id;

        await routesCollection.doc(docId).update(
          {
            'code_bus': route.codeBus,
            'description': route.description,
            'name': route.name,
          },
        );
      } else {
        throw Exception(ErrorNotFound("A rota"));
      }
    } catch (e) {
      throw Exception(ErrorUpdate("rota", e));
    }
  }
}
