import 'package:flutter/material.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/screens/login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool isEstudante =
      false; // Variável para rastrear se a opção é "Estudante" ou "Motorista"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
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
        LoginInput("Nome"),
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
        LoginInput("Nome"),
        LoginInput("Número da Carteira"),
        SizedBox(height: 20.0),
        LoginCardButton(Login(), "Cadastrar Motorista")
      ],
    );
  }
}
