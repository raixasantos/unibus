import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:unibus/models/advice_notification.dart';

class NotificationProvider with ChangeNotifier {
  final List<AdviceNotification> _list = [];

  NotificationProvider() {}

  // listar
  UnmodifiableListView<AdviceNotification> get list =>
      UnmodifiableListView(_list);

  // adicionar
  addNotification(AdviceNotification notification) {
    _list.add(notification);
    notifyListeners();
  }
}
