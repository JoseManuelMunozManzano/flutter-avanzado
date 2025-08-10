import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/bloc/user/user_bloc.dart';
import 'package:estados/models/usuario.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos la instancia de nuestro bloc, que ya sabemos que se encuentra en el context.
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Pagina 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                final newUser = Usuario(
                  nombre: 'José Manuel',
                  edad: 46,
                  profesiones: ['FullStack Developer'],
                );

                // Cambiamos el estado añadiendo un evento, usando el método add.
                userBloc.add(ActivateUser(newUser));
              },
              color: Colors.blue,
              child: Text(
                'Establecer Usuario',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                userBloc.add(ChangeUserAge(25));
              },
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              onPressed: () {
                if (userBloc.state.existUser) {
                  int numProfesion = userBloc.state.user!.profesiones.length + 1;
                  userBloc.add(AddUserProfession('Profesion $numProfesion'));
                }
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
