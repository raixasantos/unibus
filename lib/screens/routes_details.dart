import 'package:flutter/material.dart';
import 'package:unibus/constants/colors.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/RouteProvider.dart';

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

  @override
  void initState() {
    super.initState();
    nameController.text = widget.route.name;
    descriptionController.text = widget.route.description;
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
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                            style: TextStyle(
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
                    Text(
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
                            style: TextStyle(
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                  child: Text("Editar"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
