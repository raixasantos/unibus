import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importe o cloud_firestore
import 'package:unibus/components/RouteProvider.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:unibus/services/routes_services.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/screens/createStop.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({Key? key}) : super(key: key);

  @override
  _CreateRouteState createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  @override
  Widget build(BuildContext context) {
    final createRouteProvider = Provider.of<RouteProvider>(context);
    final routeServices = RouteServices();
    final firestore =
        FirebaseFirestore.instance; // Crie uma instância do Firestore

    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Rota"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: createRouteProvider.nameController,
              decoration: InputDecoration(labelText: "Nome da Rota"),
            ),
            TextField(
              controller: createRouteProvider.descriptionController,
              decoration: InputDecoration(labelText: "Descrição da Rota"),
            ),
            const SizedBox(height: 20.0),
            LoginCardButton(
                Text(
                    "Adicionar Parada"), // Use um widget de texto no lugar de uma função
                "Adicionar Parada", onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateStop()));
            }),
            ElevatedButton(
              onPressed: () async {
                // Ao pressionar o botão de adicionar
                final name = createRouteProvider.nameController.text;
                final description =
                    createRouteProvider.descriptionController.text;

                // Verifique se o nome ou a descrição estão vazios
                if (name.isEmpty || description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Nome e descrição da rota são obrigatórios."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Use o método getRoutes para obter todas as rotas existentes
                final querySnapshot =
                    await firestore.collection("routes").get();
                int maxId = 0;

                // Encontre o maior ID existente
                for (var doc in querySnapshot.docs) {
                  final data = doc.data() as Map<String, dynamic>;
                  final int codeBus = data['code_bus'] ?? 0;
                  if (codeBus > maxId) {
                    maxId = codeBus;
                  }
                }

                // Incremente o maior ID em 1 para criar um novo ID
                int newid = maxId + 1;

                // Chame o serviço para adicionar a rota com o novo ID
                await routeServices.addRoute(
                  RouteBus(
                    name: name,
                    description: description,
                    codeBus: newid,
                  ),
                );

                // Limpar os controladores após adicionar a rota
                createRouteProvider.clearControllers();

                Navigator.pop(context);
              },
              child: Text("Adicionar Rota"),
            ),
          ],
        ),
      ),
    );
  }
}
