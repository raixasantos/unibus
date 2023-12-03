import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Parada.dart';
import '../components/ParadaProvider.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/services/parada_services.dart';

class CreateStop extends StatefulWidget {
  final int codeBus;
  const CreateStop({Key? key, required this.codeBus}) : super(key: key);

  @override
  _CreateStopState createState() => _CreateStopState();
}

class _CreateStopState extends State<CreateStop> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng? selectedPosition; // Adiciona uma variável para a posição selecionada
  final ParadaServices _paradaServices = ParadaServices();

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _openMap(double latitude, double longitude) {
    if (selectedPosition != null) {
      markers.removeWhere((marker) => marker.markerId.value == 'selected');
    }

    markers.add(
      Marker(
        markerId: MarkerId("parada"),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: "Nome da Parada",
          snippet: "Endereço Completo",
        ),
      ),
    );

    mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(latitude, longitude),
      ),
    );

    setState(() {
      selectedPosition = LatLng(latitude, longitude);
    });
  }

  Future<void> _searchStop() async {
    final paradaProvider = Provider.of<ParadaProvider>(context, listen: false);
    final coordenadas = await _paradaServices.getLatLong(
      paradaProvider.rua,
      paradaProvider.cidade,
      paradaProvider.numero,
    );

    if (coordenadas.isNotEmpty) {
      paradaProvider.lat = coordenadas[0];
      paradaProvider.long = coordenadas[1];
      print(
          'Latitude: ${paradaProvider.lat}, Longitude: ${paradaProvider.long}');

      // Atualiza o mapa com as novas coordenadas
      _openMap(paradaProvider.lat, paradaProvider.long);
    } else {
      print('Erro ao obter coordenadas.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Parada"),
      ),
      body: ListView(padding: EdgeInsets.all(10), children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LoginInput(
                "Nome",
                onChange: (value) {
                  final paradaProvider =
                      Provider.of<ParadaProvider>(context, listen: false);
                  paradaProvider.nome = value;
                },
              ),
              LoginInput(
                "Rua",
                onChange: (value) {
                  final paradaProvider =
                      Provider.of<ParadaProvider>(context, listen: false);
                  paradaProvider.rua = value;
                },
              ),
              LoginInput(
                "cidade",
                onChange: (value) {
                  final paradaProvider =
                      Provider.of<ParadaProvider>(context, listen: false);
                  paradaProvider.cidade = value;
                },
              ),
              LoginInput(
                "Numero",
                onChange: (value) {
                  final paradaProvider =
                      Provider.of<ParadaProvider>(context, listen: false);
                  paradaProvider.numero = int.parse(value);
                },
              ),
              Consumer<ParadaProvider>(
                  builder: (context, paradaProvider, child) {
                return LoginCardButton(
                  Text("Buscar Parada"),
                  "Buscar Parada",
                  onPressed: _searchStop,
                );
              }),
              SizedBox(height: 20),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Nome da Parada"),
                      subtitle: Text("Endereço Completo"),
                      onTap: () {
                        if (markers.isNotEmpty) {
                          // Abre o mapa ao clicar na parada
                          final marker = markers.first;
                          _openMap(
                            marker.position.latitude,
                            marker.position.longitude,
                          );
                        }
                      },
                    ),
                    Container(
                      height: 200,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(-5.8379, -35.2055),
                          zoom: 15.0,
                        ),
                        onTap: (LatLng position) {
                          // Adiciona um marcador clicável
                          markers.removeWhere(
                              (marker) => marker.markerId.value == 'selected');
                          markers.add(
                            Marker(
                              markerId: MarkerId('selected'),
                              position: position,
                              draggable: true,
                              onDragEnd: (newPosition) {
                                setState(() {
                                  selectedPosition = newPosition;
                                });
                              },
                            ),
                          );
                          setState(() {
                            selectedPosition = position;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              LoginCardButton(
                Text("Adicionar parada"),
                "Adicionar parada",
                onPressed: () async {
                  final paradaProvider =
                      Provider.of<ParadaProvider>(context, listen: false);
                  final novaParada = Parada(
                    codeBus: widget.codeBus,
                    nome: paradaProvider.nome,
                    rua: paradaProvider.rua,
                    cidade: paradaProvider.cidade,
                    numero: paradaProvider.numero,
                    lat: selectedPosition?.latitude ?? 0,
                    long: selectedPosition?.longitude ?? 0,
                  );

                  await paradaProvider.addParada(novaParada);
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}
