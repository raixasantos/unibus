import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unibus/models/Parada.dart';
import 'package:unibus/services/parada_services.dart';

class ParadaProvider with ChangeNotifier {
  String _nome = '';
  int _codeBus = 0;
  String _rua = '';
  String _cidade = '';
  int _numero = 0;
  double _lat = 0;
  double _long = 0;

  ParadaServices paradaServices = ParadaServices();

  final List<Parada> _listFromBus = [];

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
    print("Tem Nome");
    notifyListeners();
  }

  int get codeBus => _codeBus;

  set codeBus(int value) {
    _codeBus = value;
    print("Tem Nome da rota");
    notifyListeners();
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
    print("Tem cidade");
    notifyListeners();
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
    print("Tem Rua");
    notifyListeners();
  }

  int get numero => _numero;

  set numero(int value) {
    _numero = value;
    print("Tem Numero");
    notifyListeners();
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
    print("Tem Latitude");
    notifyListeners();
  }

  double get long => _long;

  set long(double value) {
    _long = value;
    print("Tem Rua");
    notifyListeners();
  }

  Future<void> addParada(Parada parada) async {
    await paradaServices.addParada(parada);
    await paradaServices.getStopsByCodeBus(parada.codeBus);
    notifyListeners();
  }

  initListStops(int codeBus) async {
    QuerySnapshot snapshot = await paradaServices.getStopsByCodeBus(codeBus);
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      final parada = Parada(
          lat: data['lat'],
          long: data['long'],
          rua: data['rua'],
          cidade: data['cidade'],
          numero: data['numero'],
          nome: data['nome'],
          codeBus: data['codeBus']);

      _listFromBus.add(parada);
      notifyListeners();
    }
  }

  UnmodifiableListView<Parada> get list => UnmodifiableListView(_listFromBus);

  //Limpar a lista
  void clearList() {
    _listFromBus.clear();
  }
}
