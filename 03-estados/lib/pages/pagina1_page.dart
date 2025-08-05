import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/models/usuario.dart';
import 'package:estados/bloc/usuario/usuario_cubit.dart';

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1'),
        actions: [
          IconButton(
            onPressed: () => context.read<UsuarioCubit>().borrarUsuario(),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      // Como usar un Cubit que ya está en el context.
      body: BodyScaffold(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'pagina2'),
        child: Icon(Icons.accessibility_new),
      ),
    );
  }
}

class BodyScaffold extends StatelessWidget {
  const BodyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioCubit, UsuarioState>(
      builder: (_, state) {
        //print(state);

        switch (state) {
          case UsuarioInitial():
            return Center(child: Text('No hay información del usuario'));
          // Si no hay return, indicar aquí break;
          case UsuarioActivo():
            return InformacionUsuario(state.usuario);
          // Si no hay return, indicar aquí break;
          // Siempre tenemos que regresar un Widget, si no, la app dará error.
          default:
            return Center(child: Text('Estado no reconocido'));
        }

        // if ( state is UsuarioInitial ) {
        //   return Center(child: Text('No hay información del usuario'));
        // } else if( state is UsuarioActivo ) {
        //   return InformacionUsuario( state.usuario );
        // } else {
        //   return Center( child: Text('Estado no reconocido '));
        // }
      },
    );
  }
}

class InformacionUsuario extends StatelessWidget {
  final Usuario usuario;

  const InformacionUsuario(this.usuario, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(),

          ListTile(title: Text('Nombre: ${usuario.nombre}')),
          ListTile(title: Text('Edad: ${usuario.edad}')),

          Text(
            'Profesiones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(),

          ...usuario.profesiones.map(
            (profesion) => ListTile(title: Text(profesion)),
          ),
        ],
      ),
    );
  }
}
