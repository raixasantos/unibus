import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/NotificationProvider.dart';
import 'package:unibus/main.dart';
import 'package:unibus/models/advice_notification.dart';
import 'package:unibus/screens/home.dart';

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
      handleNotificationMessage(message, context);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationMessage(message, context);
      // Enviar para tela auxiliar
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => const Home(indexReceived: 2),
      ));
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

  Future<void> handleNotificationMessage(
      RemoteMessage message, BuildContext context) async {
    debugPrint('=======================================');
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      debugPrint("onMessage: ${notification.body!}");
      // Montar a notificação (data enviada, descrição e visto)
      AdviceNotification notificationReceived = AdviceNotification(
          date: DateTime.now(), description: notification.body!, seen: false);
      // Salvar no service de mensagem
      Provider.of<NotificationProvider>(context, listen: false)
          .addNotification(notificationReceived);
    }
    debugPrint('=======================================');
  }
}
