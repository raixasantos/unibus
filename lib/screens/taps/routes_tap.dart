import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/RouteProvider.dart';
import 'package:unibus/data/data.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:unibus/screens/createRoute.dart';
import 'package:unibus/widgets/custom_app_bar.dart';
import 'package:unibus/widgets/custom_route_card.dart';
import 'package:unibus/widgets/custom_text_form_field.dart';
import 'package:unibus/services/routes_services.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  TextEditingController searchController = TextEditingController();
  List<RouteBus> routesBus = routes; // Consumer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Rotas",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<RouteProvider>(builder: (context, routes, child) {
                return routes.list.isEmpty
                    ? const ListTile(
                        leading: Icon(Icons.route),
                        title: Text('Ainda não há rotas'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: routes.list.length,
                        itemBuilder: (context, index) {
                          final route = routes.list[index];
                          return RouteCard(route);
                        });
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Aguarde até que o usuário conclua a criação da rota
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRoute()),
          );

          // Limpe a lista antes de atualizá-la
          Provider.of<RouteProvider>(context, listen: false).clearList();

          // Após a conclusão da criação da rota, atualize a lista
          Provider.of<RouteProvider>(context, listen: false).initList();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
