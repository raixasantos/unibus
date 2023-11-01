import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/RouteProvider.dart';
import 'package:unibus/data/data.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:unibus/widgets/custom_app_bar.dart';
import 'package:unibus/widgets/custom_route_card.dart';
import 'package:unibus/widgets/custom_text_form_field.dart';

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
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /* CustomTextFormField(
              hint: "Buscar rotas",
              prefixIcon: Icons.search,
              controller: searchController,
              filled: true,
            ), */
            // colocar favoritados
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
          ]),
        ),
      ),
    );
  }
}
