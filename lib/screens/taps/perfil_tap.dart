import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/models/Usuario.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/services/user_services.dart';
import 'package:unibus/widgets/custom_app_bar.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    deletarUsuario(Usuario user) async {
      UserServices userServices = UserServices();
      userServices.deleteUser(user.nome);
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login()));
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Perfil",
      ),
      body: Column(
        children: [
          Row(
            children: [
              Consumer<UserProvider>(builder: (context, userProvider, child) {
                return TextButton(
                    onPressed: () {
                      deletarUsuario(userProvider.user);
                    },
                    child: Text("Deletar Usuário"));
              },
              ),
              Consumer<UserProvider>(builder: (context, userProvider, child) {
                return Text(userProvider.user.nome);
              }),
            ],
          )
        ],
      ),
    );
  }
}
