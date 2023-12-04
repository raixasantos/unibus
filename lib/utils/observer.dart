import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/ParadaProvider.dart';

class RouteDetailsObserver extends NavigatorObserver {
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name == '/route_details') {
      // Limpar a lista quando o RouteDetailsPage for removido
      Provider.of<ParadaProvider>(previousRoute!.navigator!.context,
              listen: false)
          .clearList();
    }
  }
}
