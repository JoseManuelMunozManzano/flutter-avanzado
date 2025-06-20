import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

// Este ChangeNotifier me va a ayudar a decirle a Provider cuando tiene que refrescar el UI, o
// cuando quiera notificar a todas las personas que estén trabajando con este SocketService.
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Importante indicar nuestra IP o http://10.0.2.2:3000 para emuladores de Android.
    // Para iOS se puede usar http://localhost:3000.
    // Cuando se lleve a producción habrá que cambiar esta IP por el dominio del servidor.
    _socket = IO.io('http://192.168.50.124:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      // print('connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      // print('disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // No poner tipado al payload, ya que puede ser cualquier cosa.
    // Como esto es hardcode, no lo vamos a hacer así, esto era solo un ejemplo.
    //
    // socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje:');
    //   print('nombre: ' + payload['nombre']);
    //   print('mensaje: ' + payload['mensaje']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    // });

    // Para evitar duplicados si se vuelve a conectar.
    // socket.off('nuevo-mensaje');
  }
}
