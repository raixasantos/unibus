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

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  bool _showErrorMessage = false;
  String _errorMessage = '';

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

  Future<void> _searchAddress(LatLng? position) async {
    if (position != null) {
      final paradaProvider =
          Provider.of<ParadaProvider>(context, listen: false);

      final addressInfo = await _paradaServices.getAddressFromCoordinates(
          position.latitude, position.longitude);

      if (addressInfo.isNotEmpty) {
        // Atualiza os campos diretamente no estado local
        setState(() {
          paradaProvider.rua = addressInfo['rua'] ?? '';
          paradaProvider.cidade = addressInfo['cidade'] ?? '';
          paradaProvider.numero =
              int.tryParse(addressInfo['numero'] ?? '') ?? 0;

          // Atualiza os controladores
          ruaController.text = paradaProvider.rua;
          cidadeController.text = paradaProvider.cidade;
          numeroController.text = paradaProvider.numero.toString();
        });
      } else {
        // Exibe a mensagem de erro
        setState(() {
          _showErrorMessage = true;
          _errorMessage = 'Erro ao obter informações do endereço.';
        });
      }
    } else {
      // Exibe a mensagem de erro
      setState(() {
        _showErrorMessage = true;
        _errorMessage = 'Posição nula.';
      });
    }
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

      // Atualiza os controladores
      ruaController.text = paradaProvider.rua;
      cidadeController.text = paradaProvider.cidade;
      numeroController.text = paradaProvider.numero.toString();

      // Limpa a mensagem de erro se estiver visível
      setState(() {
        _showErrorMessage = false;
        _errorMessage = '';
      });
    } else {
      // Exibe a mensagem de erro
      setState(() {
        _showErrorMessage = true;
        _errorMessage = 'Erro ao obter coordenadas. Verifique os dados.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Parada"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LoginInput(
                  "Nome",
                  controller: nomeController,
                  onChange: (value) {
                    final paradaProvider =
                        Provider.of<ParadaProvider>(context, listen: false);
                    paradaProvider.nome = value;
                  },
                ),
                LoginInput(
                  "Rua",
                  controller: ruaController,
                  onChange: (value) {
                    final paradaProvider =
                        Provider.of<ParadaProvider>(context, listen: false);
                    paradaProvider.rua = value;
                  },
                ),
                LoginInput(
                  "cidade",
                  controller: cidadeController,
                  onChange: (value) {
                    final paradaProvider =
                        Provider.of<ParadaProvider>(context, listen: false);
                    paradaProvider.cidade = value;
                  },
                ),
                LoginInput(
                  "Numero",
                  controller: numeroController,
                  onChange: (value) {
                    final paradaProvider =
                        Provider.of<ParadaProvider>(context, listen: false);
                    paradaProvider.numero = int.parse(value);
                  },
                ),
                Consumer<ParadaProvider>(
                    builder: (context, paradaProvider, child) {
                  return LoginCardButton(
                    Text("Buscar no mapa"),
                    "Buscar no mapa",
                    onPressed: _searchStop,
                  );
                }),

                // Exibe a mensagem de erro, se aplicável
                if (_showErrorMessage)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

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
                            markers.removeWhere((marker) =>
                                marker.markerId.value == 'selected');
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

                // Texto para buscar informações
                LoginCardButton(
                  Text("Buscar Informações"),
                  "Buscar Informações",
                  onPressed: () async {
                    await _searchAddress(selectedPosition);
                  },
                ),

                // Botão para adicionar parada
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

                    // Exibe a mensagem de erro se não foi possível adicionar a parada
                    try {
                      await paradaProvider.addParada(novaParada);
                      // ...
                    } catch (error) {
                      // Notifica o erro de forma semelhante ao código de rota
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Erro ao adicionar parada: $error"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
