import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/models/usuario.dart';
import 'package:estados/bloc/usuario/usuario_cubit.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {

    final usuarioCubit = context.read<UsuarioCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pagina 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              // Vemos como llamar a un Cubit.
              onPressed: () {
                final newUser = Usuario(
                  nombre: 'José Manuel',
                  edad: 46,
                  profesiones: ['FullStack Developer', 'Lector de cómics'],
                );
                usuarioCubit.seleccionarUsuario(newUser);
              },
              color: Colors.blue,
              child: Text(
                'Establecer Usuario',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                usuarioCubit.cambiarEdad(30);
              },
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                usuarioCubit.agregarProfesion();
              },
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
