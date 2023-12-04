import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/RouteProvider.dart';
import 'package:unibus/components/ParadaProvider.dart';

class Map extends StatefulWidget {
  const Map({Key? key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late Completer<GoogleMapController> mapController = Completer();
  LatLng initialPosition = LatLng(0, 0); // Default coordinates
  bool loadedMap = false;
  Set<Marker> _markers = {};
  int _selectedRoute = 0; // Valor padrão "Nenhuma rota"
  late ParadaProvider _paradaProvider;
  late BitmapDescriptor parada_icon;

  Future<void> trackLocation() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    setState(() {
      initialPosition = LatLng(latitude, longitude);
      _markers.add(
        Marker(
          markerId: MarkerId("userLocation"),
          position: initialPosition,
        ),
      );
    });

    if (loadedMap) {
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newLatLng(initialPosition));
    }
  }

  void load_paradaMarker() async {
    parada_icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(1, 1)), "assets/bus-stop.png");
  }

  void _loadParadas(int codeBus) async {
    await _paradaProvider.initListStops(codeBus);

    setState(() async {
      _markers.clear(); // Limpe os marcadores atuais

      if (_paradaProvider.list.isNotEmpty) {
        // Adicione marcadores apenas se a lista de paradas não estiver vazia
        _markers.addAll(
          _paradaProvider.list.map(
            (parada) => Marker(
              markerId: MarkerId(parada.nome),
              position: LatLng(parada.lat, parada.long),
              icon: parada_icon,
              infoWindow: InfoWindow(
                title: parada.nome,
                snippet: "Código do ônibus: ${parada.codeBus}",
              ),
            ),
          ),
        );
      }

      // Adicione o marcador da localização do usuário
      _markers.add(
        Marker(
          markerId: MarkerId("userLocation"),
          position: initialPosition,
        ),
      );
    });
  }

  @override
  void initState() {
    load_paradaMarker();
    super.initState();
    _paradaProvider = Provider.of<ParadaProvider>(context, listen: false);
    trackLocation();
  }

  void onMapCompleted(GoogleMapController controller) {
    mapController.complete(controller);
    loadedMap = true;
  }

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: Column(
        children: [
          // Dropdown para selecionar a rota
          DropdownButton<int>(
            value: _selectedRoute,
            items: [
              // Adicionando a opção "Nenhuma rota"
              DropdownMenuItem<int>(
                value: 0,
                child: Text('Nenhuma rota'),
              ),
              // Adicionando as rotas dinamicamente a partir do RouteProvider
              ...routeProvider.list.map((route) {
                return DropdownMenuItem<int>(
                  value: route.codeBus,
                  child: Text(route.name),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedRoute = value!;
                if (_selectedRoute != 0) {
                  // Quando o usuário seleciona uma rota, carregamos as paradas correspondentes
                  _loadParadas(_selectedRoute);
                }
              });
            },
          ),
          // Mapa
          Expanded(
            child: GoogleMap(
              key: UniqueKey(),
              initialCameraPosition:
                  CameraPosition(target: initialPosition, zoom: 15.0),
              myLocationButtonEnabled: true,
              markers: _markers,
              onMapCreated: onMapCompleted,
            ),
          ),
        ],
      ),
    );
  }
}
