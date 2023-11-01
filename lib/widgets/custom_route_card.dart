import 'package:flutter/material.dart';
import 'package:unibus/constants/colors.dart';
import 'package:unibus/models/route_bus.dart';
import 'package:unibus/screens/routes_details.dart';

class RouteCard extends StatelessWidget {
  final RouteBus route;

  const RouteCard(this.route);

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
                      route.name,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      route.description,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed("/route-detail", arguments: route);
            print("cliquei");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RouteDetailsPage(route: route),
              ),
            );
          },
        )
    );
  }
}
