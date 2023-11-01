import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/components/login/LoginCardButton.dart';
import 'package:unibus/components/login/LoginInput.dart';
import 'package:unibus/models/Usuario.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/services/user_services.dart';
import 'package:unibus/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../components/CadastroProvider.dart';
import '../models/Aluno.dart';
import '../models/Motorista.dart';

class Cadastro extends StatefulWidget {
  Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String name = "";
  cadastraUsuario() async {
    CadastroProvider cadastroProvider =
        Provider.of<CadastroProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserServices userServices = UserServices();
    Usuario novoUsuario;
    if (cadastroProvider.numeroCarteira > 0) {
      novoUsuario = Motorista(cadastroProvider.name, cadastroProvider.senha,
          cadastroProvider.numeroCarteira);
    } else {
      novoUsuario = Aluno(
          cadastroProvider.name,
          cadastroProvider.senha,
          cadastroProvider.faculdade,
          cadastroProvider.turno,
          cadastroProvider.matricula);
    }
    try {
      await userServices.CreateUser(novoUsuario);
      userProvider.user = novoUsuario;
      Fluttertoast.showToast(
          msg: "Usuário ${userProvider.user.nome} Criado!",
          webBgColor: "rgba(75, 215, 75, 1)");
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Erro ao criar usuário", webBgColor: "rgba(236, 29, 29, 1)");
    }
  }

  @override
  void initState() {
    super.initState();
    final cadastroProvider =
        Provider.of<CadastroProvider>(context, listen: false);
    print("isMotorista: ${cadastroProvider.isMotorista}");
  }

  void changeName(String newName) {
    final cadastroProvider =
        Provider.of<CadastroProvider>(context, listen: false);
    cadastroProvider.name = newName;
    setState(() {
      name = newName;
    });
  }

  Widget _buildEstudanteForm() {
    return Column(
      children: [
        LoginInput("Nome", onChange: changeName),
        LoginInput("Senha", isPassword: true, onChange: (value) {
          final cadastroProvider =
              Provider.of<CadastroProvider>(context, listen: false);
          cadastroProvider.senha = value;
        }),
        Row(
          children: [
            Expanded(
              child: LoginInput("Matrícula", onChange: (value) {
                final cadastroProvider =
                    Provider.of<CadastroProvider>(context, listen: false);
                cadastroProvider.matricula = int.parse(value);
              }),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: LoginInput("Faculdade", onChange: (value) {
                final cadastroProvider =
                    Provider.of<CadastroProvider>(context, listen: false);
                cadastroProvider.faculdade = value;
              }),
            ),
          ],
        ),
        LoginInput("Turno", onChange: (value) {
          final cadastroProvider =
              Provider.of<CadastroProvider>(context, listen: false);
          cadastroProvider.turno = value;
        }),
        const SizedBox(height: 20.0),
        Consumer<CadastroProvider>(builder: (context, cadastroProvider, child) {
          return LoginCardButton(
            Login(),
            "Cadastrar Estudante",
            onPressed: cadastroProvider.isCadastrarEnabled
                ? () {
                    // Se o botão de cadastro estiver habilitado
                    cadastraUsuario();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                : null, // Desabilitar o botão se não estiver pronto para cadastro
          );
        }),
      ],
    );
  }

  Widget _buildMotoristaForm() {
    return Column(
      children: [
        LoginInput("Nome", onChange: changeName),
        LoginInput("Senha", isPassword: true, onChange: (value) {
          final cadastroProvider =
              Provider.of<CadastroProvider>(context, listen: false);
          cadastroProvider.senha = value;
        }),
        LoginInput("Numero da Carteira", onChange: (value) {
          final cadastroProvider =
              Provider.of<CadastroProvider>(context, listen: false);
          cadastroProvider.numeroCarteira = int.parse(value);
        }),
        const SizedBox(height: 20.0),
        Consumer<CadastroProvider>(builder: (context, cadastroProvider, child) {
          return LoginCardButton(
            Login(),
            "Cadastrar Motorista",
            onPressed: cadastroProvider.isCadastrarEnabled
                ? () {
                    // Se o botão de cadastro estiver habilitado
                    cadastraUsuario();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                : null, // Desabilitar o botão se não estiver pronto para cadastro
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cadastroProvider = Provider.of<CadastroProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cadastro",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text("Bem vindo(a), ${cadastroProvider.name}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Motorista'),
              Switch(
                value: !cadastroProvider
                    .isMotorista, // Invertido para usar isMotorista
                onChanged: (value) {
                  cadastroProvider.isMotorista =
                      !value; // Invertido para usar isMotorista
                },
              ),
              const Text('Estudante'),
            ],
          ),
          const SizedBox(height: 20.0),
          cadastroProvider.isMotorista // Alterado para usar isMotorista
              ? _buildMotoristaForm()
              : _buildEstudanteForm(),
        ],
      ),
    );
  }
}
