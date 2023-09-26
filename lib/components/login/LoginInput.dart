import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String label;
  bool? isPassword;
  LoginInput(this.label, {this.isPassword});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          obscureText: widget.isPassword == true ? true : false,
          decoration: InputDecoration(hintText: widget.label),
        ));
  }
}
