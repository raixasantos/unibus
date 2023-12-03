import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibus/constants/errors.dart';
import 'package:unibus/models/Parada.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Danilo: AIzaSyCpNAuuIY9wy1ezu5zNnUOhTWa37yLNzPI

class ParadaServices {
  final GeocodingPlatform geocodingPlatform = GeocodingPlatform.instance;
  final apiKey = "hTWa37yLNzPI";

  final CollectionReference paradasCollection =
      FirebaseFirestore.instance.collection("parada");

  Future getStops() async {
    return await paradasCollection.get();
  }

  Future getStop(String nome) async {
    return await paradasCollection.where("nome", isEqualTo: nome).get();
  }

  Future<List<double>> getLatLong(String rua, String cidade, int numero) async {
    print("indo buscar");
    if (rua.isEmpty && cidade.isEmpty) {
      // Pelo menos um dos campos (rua ou cidade) deve ser preenchido
      print('Rua ou cidade deve ser preenchido.');
      return [];
    }

    // Construir a parte do endereço com os campos disponíveis
    final addressComponents = [if (numero != null) '$numero', rua, cidade];
    final formattedAddress =
        '${addressComponents.join(', ')} RN'; // Adiciona "RN" ao final

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeQueryComponent(formattedAddress)}&key=$apiKey';

    try {
      print('URL: $url');
      print("Mandando a URL");
      //final response = await http.get(Uri.parse(url));

      /*if (response.statusCode == 200) {
        print("Decodificando resposta");
        final decodedResponse = json.decode(response.body);

        if (decodedResponse['status'] == 'OK') {
          print("resposta ok");
          final results = decodedResponse['results'];
          if (results.isNotEmpty) {
            print("resposta não é vazia");
            final location = results[0]['geometry']['location'];
            final double latitude = location['lat'];
            final double longitude = location['lng'];
            return [latitude, longitude];
          }
        } else {
          print(decodedResponse['status']);
        }
      } else {
        //print(response.statusCode);
      }*/
    } catch (error) {
      print('Erro ao obter coordenadas: $error');
    }

    return [
      -5.634078058398252,
      -35.42468085659013
    ]; // Em caso de erro ou nenhum resultado válido
  }

  Future<void> addParada(Parada parada) async {
    try {
      final existingRoute =
          await paradasCollection.where('name', isEqualTo: parada.nome).get();

      if (existingRoute.docs.isEmpty) {
        await paradasCollection.add(
          {
            'codeBus': parada.codeBus,
            'nome': parada.nome,
            'rua': parada.rua,
            'numero': parada.numero,
            'cidade': parada.cidade,
            'lat': parada.lat,
            'long': parada.long
          },
        );
      } else {
        throw Exception(ErrorExists("A parada"));
      }
    } catch (e) {
      throw Exception(ErrorAdd("parada", e));
    }
  }

  Future<void> removeParada(Parada parada) async {
    print("Estou no service para excluir: ${parada.nome}");
    QuerySnapshot queryResult = await FirebaseFirestore.instance
        .collection('parada')
        .where('nome', isEqualTo: parada.nome)
        .get();
    queryResult.docs[0].reference.delete();
  }

  Future<void> updateParada(Parada parada) async {
    QuerySnapshot queryResult = await FirebaseFirestore.instance
        .collection('parada')
        .where('nome', isEqualTo: parada.nome)
        .get();
    print(queryResult);
    queryResult.docs[0].reference.update({
      'codeBus': parada.codeBus,
      'nome': parada.nome,
      'rua': parada.rua,
      'numero': parada.numero,
      'cidade': parada.cidade,
      'lat': parada.lat,
      'long': parada.long
    });
  }

  Future getStopsByCodeBus(int codeBus) async {
    return await paradasCollection.where('codeBus', isEqualTo: codeBus).get();
  }
}
