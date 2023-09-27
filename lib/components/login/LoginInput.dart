import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String label;
  bool? isPassword;
  TextEditingController? controller;
  ValueChanged<String>? onChange;
  LoginInput(this.label, {this.isPassword, this.controller, this.onChange});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: widget.controller != null? widget.controller : null,
          obscureText: widget.isPassword == true ? true : false,
          decoration: InputDecoration(hintText: widget.label),
          onChanged: (text) {
            if(widget.onChange != null){
              widget.onChange!(text);
            }
          },
        ));
  }
}
