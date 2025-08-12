import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estados/controllers/usuario_controller.dart';
import 'package:estados/models/usuario.dart';

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyectamos el controller en el context que se encuentra manejado por GetX.
    // Ahora puedo obtener en toda la app (después de haber pasado por aquí) la misma instancia.
    final usuarioCtrl = Get.put(UsuarioController());

    return Scaffold(
      appBar: AppBar(title: const Text('Pagina 1')),
      // Para de manera condicional mostrar uno u otro widget usando la programación reactiva de GetX.
      // Cada vez que una propiedad cambie, redibujamos el widget.
      body: Obx(
        () =>
            usuarioCtrl.existeUsuario.value
                ? InformacionUsuario(usuario: usuarioCtrl.usuario.value)
                : NoInfo(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Get.toNamed(
              'pagina2',
              arguments: {'nombre': 'José Manuel', 'edad': 46},
            ),
        child: Icon(Icons.accessibility_new),
      ),
    );
  }
}

class NoInfo extends StatelessWidget {
  const NoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No hay usuario seleccionado'));
  }
}

class InformacionUsuario extends StatelessWidget {
  final Usuario usuario;

  const InformacionUsuario({super.key, required this.usuario});

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

          ...usuario.profesiones.map((profesion) => ListTile(title: Text(profesion))),
          
        ],
      ),
    );
  }
}
