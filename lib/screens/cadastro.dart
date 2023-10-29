import 'package:flutter/material.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/widgets/custom_app_bar.dart';

import '../models/Aluno.dart';
import '../models/Motorista.dart';

class Cadastro extends StatefulWidget {
  Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController matriculaController = TextEditingController();
  TextEditingController faculdadeController = TextEditingController();
  TextEditingController turnoController = TextEditingController();
  TextEditingController numeroCarteiraController = TextEditingController();

  String name = "";
  String senha = ""; // Adicione uma variável para armazenar a senha

  void changeName(String newName) {
    setState(() {
      name = newName;
    });
  }

  bool isEstudante = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cadastro",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text("Bem vindo(a), $name"),
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
        LoginInput("Nome", controller: nameController, onChange: changeName),
        LoginInput("Senha", isPassword: true, controller: null,
            onChange: (value) {
          senha = value;
        }),
        Row(
          children: [
            Expanded(
              child: LoginInput("Matrícula", controller: matriculaController),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: LoginInput("Faculdade", controller: faculdadeController),
            ),
          ],
        ),
        LoginInput("Turno", controller: turnoController),
        SizedBox(height: 20.0),
        LoginCardButton(
          Login(),
          "Cadastrar Estudante",
          onPressed: () {
            // Obter os valores dos controladores
            String name = nameController.text;
            String matriculaValue = matriculaController.text;
            String faculdadeValue = faculdadeController.text;
            String turnoValue = turnoController.text;
            String senhaValue = senha; // Obter a senha

            // Criar um objeto Aluno
            Aluno aluno = Aluno(name, int.parse(matriculaValue), senhaValue,
                faculdadeValue, turnoValue);

            // Imprimir o objeto Aluno
            print(aluno);
          },
        ),
      ],
    );
  }

  Widget _buildMotoristaForm() {
    return Column(
      children: [
        LoginInput("Nome", controller: nameController, onChange: changeName),
        LoginInput("Senha", isPassword: true, controller: null,
            onChange: (value) {
          senha = value;
        }),
        LoginInput("Número da Carteira", controller: numeroCarteiraController),
        SizedBox(height: 20.0),
        LoginCardButton(
          Login(),
          "Cadastrar Motorista",
          onPressed: () {
            // Obter os valores dos controladores
            String name = nameController.text;
            String numeroCarteiraValue = numeroCarteiraController.text;
            String senhaValue = senha; // Obter a senha

            // Criar um objeto Motorista
            Motorista motorista = Motorista(
                name, int.parse(numeroCarteiraValue), senhaValue, 'sua_agenda');

            // Imprimir o objeto Motorista
            print(motorista);
          },
        ),
      ],
    );
  }
}
