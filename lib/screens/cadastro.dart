import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool isEstudante =
      false; // Variável para rastrear se a opção é "Estudante" ou "Motorista"
  String dropdownValue = 'Diurno';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: Colors.yellow[800],
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width *
                0.25), // Largura de 25% nas laterais
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Card(
              elevation: 3,
              color: Colors.grey[300],
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 20.0), // Espaço entre Card e ContainerPrincipal
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstudanteForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormField('Nome', 'Digite seu nome'),
        SizedBox(height: 10.0),
        _buildFormField('Matrícula', 'Digite sua matrícula'),
        SizedBox(height: 10.0),
        _buildFormField('Faculdade', 'Digite o nome da faculdade'),
        SizedBox(height: 10.0),
        _buildDropdownField(),
        SizedBox(height: 10.0),
        _buildFormField('Senha', 'Digite sua senha', isPassword: true),
        SizedBox(height: 10.0),
        _buildFormField('Confirmar Senha', 'Confirme sua senha',
            isPassword: true),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            print("Oi Estudante");
          },
          child: Text('Cadastrar Estudante'),
        ),
      ],
    );
  }

  Widget _buildMotoristaForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFormField('Nome', 'Digite seu nome'),
        SizedBox(height: 10.0),
        _buildFormField('Número da Carteira', 'Digite o número da carteira'),
        SizedBox(height: 10.0),
        _buildFormField('Senha', 'Digite sua senha', isPassword: true),
        SizedBox(height: 10.0),
        _buildFormField('Confirmar Senha', 'Confirme sua senha',
            isPassword: true),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            print("Oi motorista");
          },
          child: Text('Cadastrar Motorista'),
        ),
      ],
    );
  }

  Widget _buildFormField(String label, String hintText,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              obscureText: isPassword,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Turno'),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Diurno', 'Matutino', 'Vespertino', 'Noturno']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
