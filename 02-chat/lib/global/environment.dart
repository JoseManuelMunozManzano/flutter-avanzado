import 'dart:io';

class Environment {
  // En iOS funciona el localhost, pero en Android no.
  // Lo mejor es usar la IP de la máquina siempre.
  // Esto para los servicios REST.
  static String apiUrl =
      Platform.isAndroid
          ? '192.168.50.124:3000'
          : 'localhost:3000';

  // Esto para los servicios de sockets.
  static String socketUrl =
      Platform.isAndroid
          ? 'http://192.168.50.124:3000'
          : 'http://localhost:3000';
}
