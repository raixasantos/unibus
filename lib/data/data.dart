import 'package:unibus/models/Parada.dart';
import 'package:unibus/models/advice_notification.dart';
import 'package:unibus/models/route_bus.dart';

final List<AdviceNotification> advices = [
  AdviceNotification(
      date: DateTime.now(),
      description:
          "Os ônibus da rota UFRN sairão às 11h da garagem amanhã (28/09/2023).",
      seen: false),
  AdviceNotification(
      date: DateTime.now(),
      description:
          "O ônibus da rota Cidade Alta sairá às 13h da Praça Cívica na próxima terça (03/10/2023).",
      seen: false),
  AdviceNotification(
      date: DateTime(2023, 9, 24),
      description:
          "Devido ao aniversário da cidade, a parada da Igreja Matriz está inoperante temporariamente.",
      seen: false),
  AdviceNotification(
      date: DateTime(2023, 9, 23),
      description:
          "A partir de 1º de Setembro, a rota Cidade Alta também estará operante no turno vespertino. Verifiquem os horários.",
      seen: false),
];

final List<RouteBus> routes = [
  RouteBus(
      name: "UFRN",
      description: "Destino: Universidade Federal do Rio Grande do Norte",
      codeBus: 4),
  RouteBus(
      name: "Cidade Alta",
      description: "Destino: Instituições da Cidade Alta",
      codeBus: 2),
  RouteBus(
      name: "Zona Sul",
      description: "Destino: Instituições da Zona Norte",
      codeBus: 3)
];

final List<Parada> paradas = [];
