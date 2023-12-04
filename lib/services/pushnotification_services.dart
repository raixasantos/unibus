import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/NotificationProvider.dart';
import 'package:unibus/models/advice_notification.dart';
import 'package:unibus/screens/taps/notification_tap.dart';

class PushNotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future initialize(BuildContext context) async {
    await _firebaseMessaging.requestPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('=======================================');
      debugPrint("onMessage: $message, adicione o local mulher");
      debugPrint('=======================================');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: $message");
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        // Montar a notificação (data enviada, descrição e visto-true)
        AdviceNotification notificationReceived = AdviceNotification(
            date: DateTime.now(), description: notification.body!, seen: false);
        // Salvar no service de mensagem (método provider)
        Provider.of<NotificationProvider>(context, listen: false)
            .addNotification(notificationReceived);
      }
      // Enviar para tela auxiliar (telinha pra ver os detalhes e retornar a tela de listagem das notificações)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NotificationTap(),
        ),
      );
    });
  }

  Future<String?> getFirebaseToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('=======================================');
    debugPrint("onMessage: ${message.notification?.title}");
    debugPrint('=======================================');
  }
}
