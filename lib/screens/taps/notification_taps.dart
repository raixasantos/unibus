import 'package:flutter/material.dart';
import 'package:unibus/widgets/custom_advice_notification.dart';

class NotificationTap extends StatelessWidget {
  const NotificationTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Notificações")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Hoje"), CustomAdviceNotification()],
        ),
      ),
    ));
  }
}
