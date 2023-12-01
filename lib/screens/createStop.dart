import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Parada.dart';
import '../components/ParadaProvider.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/services/parada_services.dart';

class CreateStop extends StatefulWidget {
  const CreateStop({Key? key}) : super(key: key);

  @override
  _CreateStopState createState() => _CreateStopState();
}

class _CreateStopState extends State<CreateStop> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  final ParadaServices _paradaServices =
      ParadaServices(); // Instância do serviço

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _openMap(double latitude, double longitude) {
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
  }

  Future<void> _searchStop() async {
    print("Começando as busca");
    final paradaProvider = Provider.of<ParadaProvider>(context, listen: false);
    final endereco =
        '${paradaProvider.rua} ${paradaProvider.numero}, ${paradaProvider.bairro}';

    final coordenadas = await _paradaServices.getLatLong(
      paradaProvider.rua,
      paradaProvider.bairro,
      paradaProvider.numero,
    );

    if (coordenadas.isNotEmpty) {
      final latitude = coordenadas[0];
      final longitude = coordenadas[1];
      print('Latitude: $latitude, Longitude: $longitude');

      // Atualiza o mapa com as novas coordenadas
      _openMap(latitude, longitude);
    } else {
      print('Erro ao obter coordenadas.2');
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
                "Bairro",
                onChange: (value) {
                  final paradaProvider =
                      Provider.of<ParadaProvider>(context, listen: false);
                  paradaProvider.bairro = value;
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
                          // Abra o mapa ao clicar na parada
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
