import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/LoginProvider.dart';
import 'package:unibus/components/LoginProvider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/models/Aluno.dart';
import 'package:unibus/models/Motorista.dart';
import 'package:unibus/models/Usuario.dart';
import 'package:unibus/screens/cadastro.dart';
import 'package:unibus/services/login_services.dart';
import 'package:unibus/widgets/custom_app_bar.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  getUserData() async {
    LoginServices loginServices = LoginServices();
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    QuerySnapshot query =
        await loginServices.getUser(loginProvider.name, loginProvider.senha);
    Usuario user;
    print("TESTEEEEEEEEEEEEE");
    print(query.docs.length);
    if (query.docs.length > 0) {
      if (query.docs[0]["numeroCarteira"] > 0 == false) {
        user = Aluno(
            query.docs[0]["nome"],
            query.docs[0]["password"],
            query.docs[0]["faculdade"],
            query.docs[0]["turno"],
            query.docs[0]["matricula"],
            imageUrl: File(query.docs[0]["imageUrl"]));
      } else {
        user = Motorista(query.docs[0]["nome"], query.docs[0]["password"],
            query.docs[0]["numeroCarteira"],
            imageUrl: File(query.docs[0]["imageUrl"]));
      }
      /* SALVANDO O USUÁRIO NO PROVIDER */
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      userProvider.user = user;
      print("Entrou na função!!!!!!!!!!!!!!!!!!!!!!!");
      /* ENVIANDO PARA TELA HOME */
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Fluttertoast.showToast(
          msg: "Não foram encontrados usuários com os dados especificados.",
          webBgColor: "red");
    }
  }

  void _login() async {
    getUserData();
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
                        final loginProvider =
                            Provider.of<LoginProvider>(context, listen: false);
                        loginProvider.name = value;
                      }),
                      LoginInput(
                        "Senha",
                        isPassword: true,
                        onChange: (value) {
                          final loginProvider = Provider.of<LoginProvider>(
                              context,
                              listen: false);
                          loginProvider.senha = value;
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) {
                        return LoginCardButton(
                          Text(
                              "Login"),
                          "Login",
                          onPressed: loginProvider.isLogarEnabled
                              ? _login
                              : null, // Função a ser executada quando o botão for pressionado
                        );
                      }),
                      Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) {
                        return LoginCardButton(
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
                        );
                      })
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
