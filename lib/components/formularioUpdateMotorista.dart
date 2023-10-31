import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/models/Motorista.dart';

class FormularioUpdateMotorista extends StatefulWidget {
  const FormularioUpdateMotorista({super.key});

  @override
  State<FormularioUpdateMotorista> createState() => _FormularioUpdateMotoristaState();
}

class _FormularioUpdateMotoristaState extends State<FormularioUpdateMotorista> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo de Nome do Usuário
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome"),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  Motorista motorista = userProvider.user as Motorista;
                  return TextField(
                    onChanged: (value) {
                      motorista.nome = value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        // Campos de Faculdade, Número da Carteira e Senha
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Senha"),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  Motorista motorista = userProvider.user as Motorista;
                  return TextField(
                    onChanged: (value) {
                      motorista.password = value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Número da Carteira"),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  Motorista motorista = userProvider.user as Motorista;
                  return TextField(
                    onChanged: (value) {
                      motorista.numeroCarteira = value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
