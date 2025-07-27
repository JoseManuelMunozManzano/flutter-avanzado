import 'package:flutter/material.dart';

import 'package:estados/models/usuario.dart';
import 'package:estados/services/usuario_service.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: usuarioService.usuarioStream,
          builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
            return snapshot.hasData
                ? Text('Nombre: ${snapshot.data!.nombre}')
                : Text('Pagina 2');
          },
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                final nuevoUsuario = Usuario(
                  nombre: 'José Manuel',
                  edad: 47,
                  profesiones: ['Ingeniero', 'Desarrollador'],
                );

                usuarioService.cargarUsuario(nuevoUsuario);
              },
              color: Colors.blue,
              child: Text(
                'Establecer Usuario',
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Notar que si no hay usuario y se pulsa este botón, no hace nada.
            // Lo dejamos así, porque lo importante es ver cambios de estado, no
            // tanto que se gestionen excepciones.
            MaterialButton(
              onPressed: () {
                usuarioService.cambiarEdad(30);
              },
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {},
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
