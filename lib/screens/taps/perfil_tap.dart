import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/components/formularioUpdateAluno.dart';
import 'package:unibus/components/formularioUpdateMotorista.dart';
import 'package:unibus/models/Aluno.dart';
import 'package:unibus/models/Usuario.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/services/user_services.dart';
import 'package:unibus/widgets/custom_app_bar.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key});

  @override
  Widget build(BuildContext context) {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    // Função para deletar o usuário após autenticação biométrica
    Future<void> deletarUsuarioAposAutenticacao(Usuario user) async {
      bool autenticado = false;

      try {
        autenticado = await _localAuthentication.authenticate(
          localizedReason: 'Toque no sensor para autenticar',
        );
      } catch (e) {
        print('Erro durante a autenticação biométrica: $e');
      }

      if (autenticado) {
        UserServices userServices = UserServices();
        userServices.deleteUser(user.nome);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Perfil",
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Botão para deletar o usuário
            Consumer<UserProvider>(builder: (context, userProvider, child) {
              if (userProvider.user is Aluno) {
                return FormularioUpdateAluno();
              } else {
                return FormularioUpdateMotorista();
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return ElevatedButton(
                      onPressed: () {
                        deletarUsuarioAposAutenticacao(userProvider.user);
                      },
                      child: Text("Excluir conta",
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
