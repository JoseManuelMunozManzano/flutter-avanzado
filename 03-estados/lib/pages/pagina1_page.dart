import 'package:estados/models/usuario.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:estados/services/usuario_service.dart';

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Si la propiedad listen=true (por defecto es así) estará pendiente de los notifyListeners()
    // de UsuarioCervice para redibujar este Widget.
    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1'),
        actions: [
          IconButton(
            onPressed: () => usuarioService.removerUsuario(),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body:
          usuarioService.existeUsuario
              ? InformacionUsuario(usuarioService.usuario!)
              : Center(child: Text('No hay usuario seleccionado')),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'pagina2'),
        child: Icon(Icons.accessibility_new),
      ),
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

          // Usamos la desestructuración de cada elemento de un array para obtener
          // los widgets de manera INDIVIDUAL.
          ...usuario.profesiones
              .map((profesion) => ListTile(title: Text(profesion)))
              .toList(),
          // ListTile(title: Text('Profesión 1')),
        ],
      ),
    );
  }
}
