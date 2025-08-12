import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estados/controllers/usuario_controller.dart';
import 'package:estados/models/usuario.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Get.arguments['nombre']);

    // Para usar una instancia de UsuarioController.
    final usuarioCtrl = Get.find<UsuarioController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pagina 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                usuarioCtrl.cargarUsuario(
                  Usuario(nombre: 'José Manuel', edad: 46),
                );
                // Mostrar notificación
                Get.snackbar(
                  'Usuario establecido',
                  'José Manuel es el nombre del usuario',
                  backgroundColor: Colors.white,
                  boxShadows: [
                    BoxShadow(color: Colors.black38, blurRadius: 10),
                  ],
                );
              },
              color: Colors.blue,
              child: Text(
                'Establecer Usuario',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                usuarioCtrl.cambiarEdad(25);
              },
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                usuarioCtrl.agregarProfesion(
                  'Profesion #${usuarioCtrl.profesionesCount + 1}',
                );
              },
              color: Colors.blue,
              child: Text(
                'Añadir Profesión',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                // Cambiar el tema de la aplicación.
                Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                );
              },
              color: Colors.blue,
              child: Text(
                'Cambiar Tema',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
