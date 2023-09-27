import 'package:flutter/material.dart';
import 'package:unibus/constants/colors.dart';
import 'package:unibus/models/advice_notification.dart';

class CustomAdviceNotification extends StatelessWidget {
  final AdviceNotification adviceNotification;

  const CustomAdviceNotification(this.adviceNotification);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            color: secondary,
            Icons.bus_alert,
            size: 30,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  adviceNotification.description,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
