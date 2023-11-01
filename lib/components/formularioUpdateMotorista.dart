import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/models/Motorista.dart';
import 'package:unibus/services/user_services.dart';

class FormularioUpdateMotorista extends StatefulWidget {
  const FormularioUpdateMotorista({super.key});

  @override
  State<FormularioUpdateMotorista> createState() => _FormularioUpdateMotoristaState();
}

class _FormularioUpdateMotoristaState extends State<FormularioUpdateMotorista> {
  atualizarDadosUsuario() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserServices userServices = UserServices();
    try {
      await userServices.updateUser(userProvider.user);
      Fluttertoast.showToast(
          msg: "Dados Atualizados", webBgColor: "rgba(75, 215, 75, 1)");
    } catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "Erro ao Atualizar Dados", webBgColor: "rgba(236, 29, 29, 1)");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        ElevatedButton(onPressed: (){
          atualizarDadosUsuario();
        }, child: Text("Atualizar Dados", style: TextStyle(color: Colors.white)), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)))
      ],
    );
  }
}
