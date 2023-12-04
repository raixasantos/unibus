import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/NotificationProvider.dart';
import 'package:unibus/widgets/custom_advice_notification.dart';
import 'package:unibus/widgets/custom_app_bar.dart';

class NotificationTap extends StatelessWidget {
  NotificationTap({super.key});

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Notificações",
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Consumer<NotificationProvider>(
                builder: (context, notifications, child) {
              final notificationslist = notifications.list;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text("Hoje"),
                  ),
                  notificationslist.isEmpty
                      ? const ListTile(
                          leading: Icon(Icons.route),
                          title: Text('Ainda não há notificações de hoje'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notificationslist.length,
                          itemBuilder: (context, index) {
                            final notification = notificationslist[index];
                            return isToday(notification.date)
                                ? CustomAdviceNotification(notification)
                                : null;
                          }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Este mês",
                    ),
                  ),
                  notificationslist.isEmpty
                      ? const ListTile(
                          leading: Icon(Icons.route),
                          title: Text('Ainda não há notificações esse mês'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notificationslist.length,
                          itemBuilder: (context, index) {
                            final notification = notificationslist[index];
                            return isThisMonth(notification.date)
                                ? CustomAdviceNotification(notification)
                                : null;
                          }),
                ],
              );
            })),
      ),
    );
  }
}
