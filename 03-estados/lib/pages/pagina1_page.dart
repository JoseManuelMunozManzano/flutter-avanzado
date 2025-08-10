import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/bloc/user/user_bloc.dart';
import 'package:estados/models/usuario.dart';

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(
                context,
                listen: false,
              ).add(DeleteUser());
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      // Cada vez que cambie el estado se va a volver a construir.
      body: BlocBuilder<UserBloc, UserState>(
        // Usar buildWhen cuando queramos redibujar solo cuando el estado actual tenga el valor, información o variable
        // que queramos. Ayuda a evitar renderizados innecesarios.
        // buildWhen: (previous, current) {},
        builder: (context, state) {
          return state.existUser
              ? InformacionUsuario(user: state.user!)
              : const Center(child: Text('No hay usuario seleccionado'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'pagina2'),
        child: Icon(Icons.accessibility_new),
      ),
    );
  }
}

class InformacionUsuario extends StatelessWidget {
  final Usuario user;

  const InformacionUsuario({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),

          ListTile(title: Text('Nombre: ${user.nombre}')),
          ListTile(title: Text('Edad: ${user.edad}')),

          const Text(
            'Profesiones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),

          ...user.profesiones.map((prof) => ListTile(title: Text(prof))),
        ],
      ),
    );
  }
}
