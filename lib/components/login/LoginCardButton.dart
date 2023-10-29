import 'package:flutter/material.dart';

class LoginCardButton extends StatefulWidget {
  final Widget? destiny;
  final String content;
  final Function? action;
  const LoginCardButton(this.content, {this.action, this.destiny});

  @override
  State<LoginCardButton> createState() => _LoginCardButtonState();
}

class _LoginCardButtonState extends State<LoginCardButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
                if (widget.action != null)
                  {
                    await widget.action!();
                    }
                if(widget.destiny != null)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => widget.destiny!));
                  }
              },
          child: Text(widget.content)),
    );
  }
}
