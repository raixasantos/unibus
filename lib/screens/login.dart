import 'package:flutter/material.dart';
import 'package:unibus/screens/cadastro.dart';
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
      appBar: AppBar(title: Text("Unibus")),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 200,
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: "Usuário"),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Senha"),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()))
                            },
                        child: Text("Login")),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cadastro()))
                            },
                        child: Text("Cadastro")),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
