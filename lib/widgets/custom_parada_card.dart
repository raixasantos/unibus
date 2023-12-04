import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/ParadaProvider.dart';
import 'package:unibus/constants/colors.dart';
import 'package:unibus/models/Parada.dart';
import 'package:unibus/services/parada_services.dart';

class ParadaCard extends StatelessWidget {
  final Parada parada;

  const ParadaCard(this.parada);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Row(
          children: [
            const Icon(
              color: secondary,
              Icons.location_on,
              size: 30,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    parada.nome,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // Chama o método de remoção no ParadaServices
                await ParadaServices().removeParada(parada);

                // Atualiza a lista em RouteDetailsPage
                Provider.of<ParadaProvider>(context, listen: false)
                    .initListStops(parada.codeBus);
              },
            ),
          ],
        ),
      ),
    );
  }
}
