import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estados/pages/pagina1_page.dart';
import 'package:estados/pages/pagina2_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'pagina1',
      // Aunque esto funciona en GetX, las rutas se pueden definir de otra manera
      // que permite inyección de dependencias.
      // routes: {
      //   'pagina1': (_) => Pagina1Page(),
      //   'pagina2': (_) => Pagina2Page(),
      // },
      getPages: [
        GetPage(name: '/pagina1', page: () => Pagina1Page()),
        GetPage(name: '/pagina2', page: () => Pagina2Page()),
      ],
    );
  }
}