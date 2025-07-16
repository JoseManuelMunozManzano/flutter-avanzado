import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/helpers/mostrar_alerta.dart';

import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Messenger'),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subtitulo: 'Crea una ahora!',
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passController,
            isPassword: true,
          ),

          BotonAzul(
            text: 'Ingrese',
            onPressed:
                authService.autenticando
                    ? null
                    : () async {
                      // Quitar el foco y el teclado.
                      FocusScope.of(context).unfocus();

                      // Aquí sé si la autenticación fue exitosa o no.
                      final loginOk = await authService.login(
                        emailController.text.trim(),
                        passController.text.trim(),
                      );

                      if (loginOk) {
                        // TODO: Conectar a nuestro socket server.
                        Navigator.pushReplacementNamed(context, 'usuarios');
                        // Ejemplo: Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(
                          context,
                          'Login incorrecto',
                          'Revise sus credenciales nuevamente',
                        );
                      }
                    },
          ),
        ],
      ),
    );
  }
}
