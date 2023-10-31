import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/models/Aluno.dart';

class FormularioUpdateAluno extends StatefulWidget {
  const FormularioUpdateAluno({super.key});

  @override
  State<FormularioUpdateAluno> createState() => _FormularioUpdateAlunoState();
}

class _FormularioUpdateAlunoState extends State<FormularioUpdateAluno> {
  
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
                  Aluno aluno = userProvider.user as Aluno;
                  return TextField(
                    onChanged: (value) {
                      aluno.nome = value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        // Campos de Matrícula e Turno
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Matrícula"),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        Aluno aluno = userProvider.user as Aluno;
                        return TextField(
                          onChanged: (value) {
                            aluno.matricula = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Turno"),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        Aluno aluno = userProvider.user as Aluno;
                        return TextField(
                          onChanged: (value) {
                            aluno.turno = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
                flex: 1,
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
              Text("Faculdade"),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  Aluno aluno = userProvider.user as Aluno;
                  return TextField(
                    onChanged: (value) {
                      aluno.faculdade = value;
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
              Text("Senha"),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  Aluno aluno = userProvider.user as Aluno;
                  return TextField(
                    onChanged: (value) {
                      aluno.senha = value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        ElevatedButton(onPressed: (){

        }, child: Text("Atualizar Dados"))
      ],
    );
  }
}
