import 'package:unibus/models/advice_notification.dart';

final List<AdviceNotification> advices = [
  AdviceNotification(
      date: DateTime.now(),
      description:
          "Os ônibus da rota UFRN sairão às 11h da garagem amanhã (28/09/2023)."),
  AdviceNotification(
      date: DateTime.now(),
      description:
          "O ônibus da rota Cidade Alta sairá às 13h da Praça Cívica na próxima terça (03/10/2023)."),
  AdviceNotification(
      date: DateTime(2023, 9, 24),
      description:
          "Devido ao aniversário da cidade, a parada da Igreja Matriz está inoperante temporariamente."),
  AdviceNotification(
      date: DateTime(2023, 9, 23),
      description:
          "A partir de 1º de Setembro, a rota Cidade Alta também estará operante no turno vespertino. Verifiquem os horários."),
];
