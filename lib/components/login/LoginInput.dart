import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String label;
  const LoginInput(this.label);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(hintText: widget.label),
        ));
  }
}
