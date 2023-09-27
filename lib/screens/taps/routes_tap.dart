import 'package:flutter/material.dart';
import 'package:unibus/data/data.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Rotas",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                child: CustomTextFormField(
                  hint: "Buscar rotas",
                  prefixIcon: Icons.search,
                  controller: searchController,
                  filled: true,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    return RouteCard(route);
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}