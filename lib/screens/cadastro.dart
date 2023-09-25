import 'package:flutter/material.dart';

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
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome'),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Matrícula'),
              ),
            ),
            SizedBox(width: 10.0), // Espaço entre os campos
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Faculdade'),
              ),
            ),
          ],
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Turno'),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implemente a lógica para salvar o cadastro de estudante aqui
          },
          child: Text('Cadastrar Estudante'),
        ),
      ],
    );
  }

  Widget _buildMotoristaForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Número da Carteira'),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implemente a lógica para salvar o cadastro de motorista aqui
          },
          child: Text('Cadastrar Motorista'),
        ),
      ],
    );
  }
}
