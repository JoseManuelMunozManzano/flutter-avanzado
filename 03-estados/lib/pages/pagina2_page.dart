import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estados/models/usuario.dart';
import 'package:estados/services/usuario_service.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // No he indicando la property listen=false, porque también queremos actualizar este
    // widget para que aparezca el usuario activo en esta pantalla.
    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            usuarioService.existeUsuario
                ? Text('Nombre: ${usuarioService.usuario!.nombre}')
                : const Text('Pagina 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                final newUser = Usuario(
                  nombre: 'José Manuel',
                  edad: 46,
                  profesiones: ['Fullstack Developer', 'Jugador de mús'],
                );
                usuarioService.usuario = newUser;
              },
              color: Colors.blue,
              child: Text(
                'Establecer Usuario',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                usuarioService.cambiarEdad(34);
              },
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () => usuarioService.agregarProfesion(),
              color: Colors.blue,
              child: Text(
                'Añadir Profesión',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
