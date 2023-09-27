import 'package:flutter/material.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/widgets/custom_app_bar.dart';

class Cadastro extends StatefulWidget {
  Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String name = "";
  void changeName(String newName) {
    setState(() {
      name = newName;
    });
  }
  bool isEstudante =
      false; // Variável para rastrear se a opção é "Estudante" ou "Motorista"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cadastro",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text("Bem vindo(a), ${name}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Estudante'),
              Switch(
                value: isEstudante,
                onChanged: (value) {
                  setState(() {
                    isEstudante = value;
                  });
                },
              ),
              Text('Motorista'),
            ],
          ),
          SizedBox(height: 20.0),
          isEstudante ? _buildMotoristaForm() : _buildEstudanteForm(),
        ],
      ),
    );
  }

  Widget _buildEstudanteForm() {
    return Column(
      children: [
        LoginInput("Nome", onChange: changeName,),
        Row(
          children: [
            Expanded(
              child: LoginInput("Matrícula"),
            ),
            SizedBox(width: 10.0), // Espaço entre os campos
            Expanded(
              child: LoginInput("Faculdade"),
            ),
          ],
        ),
        LoginInput("Turno"),
        SizedBox(height: 20.0),
        LoginCardButton(Login(), "Cadastrar Estudante")
      ],
    );
  }

  Widget _buildMotoristaForm() {
    return Column(
      children: [
        LoginInput("Nome", onChange: changeName),
        LoginInput("Número da Carteira"),
        SizedBox(height: 20.0),
        LoginCardButton(Login(), "Cadastrar Motorista")
      ],
    );
  }
}
