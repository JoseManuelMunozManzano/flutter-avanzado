import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estados/services/usuario_service.dart';

import 'package:estados/pages/pagina1_page.dart';
import 'package:estados/pages/pagina2_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Indicamos MultiProvider porque la mayor parte de las apps van a requerir más de una instancia de mi clase.
    // Se indica un arreglo de ChangeNotifierProvider, que es la forma en la que se instancia la clase.
    // La propiedad lazy por defecto es true, lo que significa que la instancia no se crea hasta que se necesite.
    // Si se pone en false, la instancia se crea inmediatamente al iniciar la app.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: true, create: (_) => UsuarioService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'pagina1',
        routes: {
          'pagina1': (_) => Pagina1Page(),
          'pagina2': (_) => Pagina2Page(),
        },
      ),
    );
  }
}