import 'package:flutter/material.dart';
import 'package:unibus/models/Usuario.dart';

class UserProvider with ChangeNotifier {
  Usuario? _user;


  set user(Usuario value) {
    _user = value;
    notifyListeners();
  }
}
