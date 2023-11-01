import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:unibus/services/routes_services.dart';

class RouteProvider with ChangeNotifier {
  final List<RouteBus> _list = [];
  final List<RouteBus> _favorites = [];
  RouteServices routeServices = RouteServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RouteProvider() {
    initList();
  }

  // Obtenha o valor inicial da rota
  RouteBus initialValue(String routeName) {
    return _list.firstWhere((route) => route.name == routeName);
  }

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
  }

  initList() async {
    QuerySnapshot snapshot = await routeServices.getRoutes();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      final route = RouteBus(
        codeBus: data['code_bus'],
        description: data['description'],
        name: data['name'],
      );

      _list.add(route);
      notifyListeners();
    }
  }

  // listar rotas
  UnmodifiableListView<RouteBus> get list => UnmodifiableListView(_list);

  UnmodifiableListView<RouteBus> get listFavorites =>
      UnmodifiableListView(_favorites);

  // adicionar rotas
  addRoute(RouteBus route) async {
    await routeServices.addRoute(route);
    _list.add(route);
    notifyListeners();
  }

  // atualizar rotas
  updateRoute(RouteBus route) async {
    await routeServices.updateRoute(route);
    int routeToUpdate =
        _list.indexWhere((routeAux) => routeAux.name == route.name);
    if (routeToUpdate != -1) _list[routeToUpdate] = route;
    notifyListeners();
  }

  // remover rotas
  removeRoute(RouteBus route) async {
    print("Estou no provider para excluir: ${route.name}");
    await routeServices.removeRoute(route);
    print("Estou no provider depois que chamei service");
    if (_list.contains(route)) _list.remove(route);
    notifyListeners();
  }

  // favoritar rotas
  favoriteRoute(RouteBus route) async {
    _favorites.add(route);
    notifyListeners();
  }

  //Limpar a lista
  void clearList() {
    _list.clear();
  }
}
