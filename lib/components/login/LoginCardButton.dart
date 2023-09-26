import 'package:flutter/material.dart';

class LoginCardButton extends StatefulWidget {
  final Widget destiny;
  final String content;
  const LoginCardButton(this.destiny, this.content);

  @override
  State<LoginCardButton> createState() => _LoginCardButtonState();
}

class _LoginCardButtonState extends State<LoginCardButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => widget.destiny))
              },
          child: Text(widget.content)),
    );
  }
}
