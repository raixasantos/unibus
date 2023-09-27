import 'package:flutter/material.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/screens/cadastro.dart';
import 'package:unibus/widgets/custom_app_bar.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Unibus"),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginInput("Usuário"),
                    LoginInput("Senha", isPassword: true),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    LoginCardButton(Home(), "Login"),
                    LoginCardButton(Cadastro(), "Cadastro")
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
