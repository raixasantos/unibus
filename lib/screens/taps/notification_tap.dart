import 'package:flutter/material.dart';
import 'package:unibus/data/data.dart';
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
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppBar(
        title: "Notificações",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hoje"),
              const SizedBox(height: 15),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: advices.length,
                  itemBuilder: (context, index) {
                    final advice = advices[index];
                    return isToday(advice.date)
                        ? CustomAdviceNotification(advice)
                        : null;
                  }),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Este mês",
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: advices.length,
                  itemBuilder: (context, index) {
                    final advice = advices[index];
                    return isThisMonth(advice.date)
                        ? CustomAdviceNotification(advice)
                        : null;
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
