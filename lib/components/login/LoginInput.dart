import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/providers/cadastro_provider.dart';

class LoginInput extends StatefulWidget {
  final String label;
  bool? isPassword;
  TextEditingController? controller;
  ValueChanged<String>? onChange;
  String? type;
  LoginInput(this.label,
      {this.isPassword, this.controller, this.onChange, this.type});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Consumer<CadastroProvider>(
          builder: (context, cadastro, child) {
            return TextField(
              controller: widget.controller != null ? widget.controller : null,
              obscureText: widget.isPassword == true ? true : false,
              decoration: InputDecoration(hintText: widget.label),
              onChanged: (text) {
                switch (widget.type) {
                  case "nome":
                    cadastro.nome = text;
                    break;
                  case "password":
                    cadastro.password = text;
                    break;
                  case "matricula":
                    cadastro.matricula = text;
                    break;
                  case "faculdade":
                    cadastro.faculdade = text;
                    break;
                  case "turno":
                    cadastro.turno = text;
                    break;
                  case "numeroCarteira":
                    cadastro.numeroCarteira = text;
                    break;
                }
                widget.onChange!(text);
              },
            );
          },
        ));
  }
}
