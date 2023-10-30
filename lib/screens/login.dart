import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/LoginProvider.dart';
import 'package:unibus/components/LoginProvider.dart';
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
  void _login() {
    // Implemente a lógica de autenticação aqui
    // Por enquanto, vamos apenas imprimir uma mensagem
    print("Realizando login...");
    // Substitua o código acima pela lógica real de autenticação
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Unibus"),
      body: Column(
        children: [
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
                      LoginInput("Usuário", onChange: (value) {
                        final loginProvider = Provider.of<LoginProvider>(context, listen: false);
                        loginProvider.name = value;
                      }),
                      LoginInput("Senha", isPassword: true, onChange: (value) {
                        final loginProvider = Provider.of<LoginProvider>(context, listen: false);
                        loginProvider.senha = value;
                      },),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Consumer<LoginProvider>(builder: (context, loginProvider, child) {
                        return LoginCardButton(
                          Text(
                              "Login"), // Use um widget de texto no lugar de uma função
                          "Login",
                          onPressed: loginProvider.isLogarEnabled? _login : null, // Função a ser executada quando o botão for pressionado
                        );
                      }),
                      LoginCardButton(
                        Text(
                            "Cadastro"), // Use um widget de texto no lugar de uma função
                        "Cadastro",
                        onPressed: () {
                          // Navegue para a tela de cadastro quando o botão for pressionado
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cadastro()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
