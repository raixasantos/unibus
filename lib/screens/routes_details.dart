import 'package:flutter/material.dart';
import 'package:unibus/components/ParadaProvider.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/constants/colors.dart';
import 'package:unibus/models/Parada.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/RouteProvider.dart';
import 'package:unibus/screens/createStop.dart';
import 'package:unibus/screens/taps/parada_tap.dart';
import 'package:unibus/widgets/custom_parada_card.dart';

import '../data/data.dart';

class RouteDetailsPage extends StatefulWidget {
  final RouteBus route;

  const RouteDetailsPage({Key? key, required this.route}) : super(key: key);

  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEditing = false;

  List<Parada> paradasStop = paradas;

  @override
  void initState() {
    super.initState();
    Provider.of<ParadaProvider>(context, listen: false).clearList();
    nameController.text = widget.route.name;
    descriptionController.text = widget.route.description;
    Provider.of<ParadaProvider>(context, listen: false)
        .initListStops(widget.route.codeBus);
  }

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Rota' : widget.route.name),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nome da Rota:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isEditing
                        ? TextField(
                            controller: nameController,
                          )
                        : Text(
                            nameController
                                .text, // Alterado para usar o controller
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Descrição da Rota:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    isEditing
                        ? TextField(
                            controller: descriptionController,
                          )
                        : Text(
                            descriptionController
                                .text, // Alterado para usar o controller
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
              ),
              if (isEditing)
                ElevatedButton(
                  onPressed: () {
                    // Salvar as alterações usando o RouteProvider
                    final updatedRoute = RouteBus(
                      name: nameController.text,
                      description: descriptionController.text,
                      codeBus: widget.route.codeBus,
                    );

                    routeProvider.updateRoute(updatedRoute);

                    // Limpar a lista antes de buscar novamente as rotas atualizadas
                    routeProvider.clearList();

                    // Buscar novamente as rotas atualizadas
                    routeProvider.initList();

                    setState(() {
                      isEditing = false;
                    });
                  },
                  child: Text("Salvar Alterações"),
                ),
              if (!isEditing)
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Alinhar o botão à direita
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          child: const Text(
                            "Editar",
                            style: TextStyle(color: form),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue))),
                    ),
                    ElevatedButton(
                        child: const Text(
                          "Excluir",
                          style: TextStyle(color: form),
                        ), // Ícone de exclusão
                        onPressed: () {
                          // Remova a rota quando o botão de exclusão for pressionado
                          Provider.of<RouteProvider>(context, listen: false)
                              .removeRoute(widget.route);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red))),
                  ],
                ),
              LoginCardButton(
                  Text(
                      "Adicionar Parada"), // Use um widget de texto no lugar de uma função
                  "Adicionar Parada", onPressed: () {
                print("Entrando em: ${widget.route.name}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateStop(
                              codeBus: widget.route.codeBus,
                            )));
              }),
              Consumer<ParadaProvider>(builder: (context, paradas, child) {
                if (paradas.list.isEmpty) {
                  return ListTile(
                    leading: Icon(Icons.route),
                    title: Text("Sem Paradas ainda"),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paradas.list.length,
                      itemBuilder: (context, index) {
                        final parada = paradas.list[index];
                        return ParadaCard(parada);
                      });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
