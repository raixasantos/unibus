import 'package:flutter/material.dart';
import 'package:unibus/constants/colors.dart';
import 'package:unibus/models/route_bus.dart';

class RouteDetailsPage extends StatefulWidget {
  final RouteBus route;

  const RouteDetailsPage({Key? key, required this.route}) : super(key: key);

  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.route.name,
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
