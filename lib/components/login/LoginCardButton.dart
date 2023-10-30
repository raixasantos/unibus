import 'package:flutter/material.dart';

class LoginCardButton extends StatefulWidget {
  final Widget destiny;
  final String content;
  final Function()? onPressed; // Novo argumento para lidar com a ação do botão
  final bool? disabled;
  const LoginCardButton(this.destiny, this.content, {this.onPressed, this.disabled});

  @override
  State<LoginCardButton> createState() => _LoginCardButtonState();
}

class _LoginCardButtonState extends State<LoginCardButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.onPressed, // Usar a função fornecida no onPressed
          child: Text(widget.content),
        ));
  }
}
