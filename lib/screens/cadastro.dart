import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/data/databaseFunctions.dart';
import 'package:unibus/providers/cadastro_provider.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/widgets/custom_app_bar.dart';

class Cadastro extends StatefulWidget {
  Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String name = "";
  late CadastroProvider provider;
  void changeName(String newName) {
    setState(() {
      name = newName;
    });
  }

  uploadData() async {
    Map<String, dynamic> data;
    print("enviando");
    if (isEstudante == true) {
      data = {
        "nome": provider.nome,
        "matricula": provider.matricula,
        "faculdade": provider.faculdade,
        "turno": provider.turno,
        "numeroCarteira": provider.numeroCarteira,
        "password": provider.password
      };
    } else {
      data = {"nome": provider.nome, "numeroCarteira": provider.numeroCarteira};
    }
    try {
      await DatabaseFunctions.createUser(data);
      print(data);
    } catch (error) {
      print(error);
    }
  }

  bool isEstudante =
      true; // Variável para rastrear se a opção é "Estudante" ou "Motorista"

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CadastroProvider>(context, listen: true);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cadastro",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(
              "Bem vindo(a), ${isEstudante ? 'Estudante' : 'Motorista'} ${name}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Motorista'),
              Switch(
                value: isEstudante,
                onChanged: (value) {
                  setState(() {
                    isEstudante = value;
                  });
                },
              ),
              Text('Estudante'),
            ],
          ),
          SizedBox(height: 20.0),
          isEstudante ? _buildEstudanteForm() : _buildMotoristaForm(),
        ],
      ),
    );
  }

  Widget _buildEstudanteForm() {
    return Column(
      children: [
        LoginInput(
          "Nome",
          type: "nome",
          onChange: changeName,
        ),
        Row(
          children: [
            Expanded(
              child: LoginInput("Matrícula", type: "matricula"),
            ),
            SizedBox(width: 10.0), // Espaço entre os campos
            Expanded(
              child: LoginInput("Faculdade", type: "faculdade"),
            ),
          ],
        ),
        LoginInput("Turno", type: "turno"),
        LoginInput("Senha", type: "password"),
        SizedBox(height: 20.0),
        LoginCardButton(destiny:Login(), "Cadastrar Estudante", action: uploadData)
      ],
    );
  }

  Widget _buildMotoristaForm() {
    return Column(
      children: [
        LoginInput("Nome", type: "nome", onChange: changeName),
        LoginInput("Número da Carteira", type: "numeroCarteira"),
        SizedBox(height: 20.0),
        LoginCardButton(destiny:Login(), "Cadastrar Motorista", action: uploadData)
      ],
    );
  }
}
