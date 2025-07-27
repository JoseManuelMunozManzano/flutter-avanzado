import 'dart:async';

import 'package:estados/models/usuario.dart';

// Vamos a controlar la forma en la que se establece información del usuario.
// Para ello, lo más fácil es hacer que la propiedad _usuario sea privada y crear getters y setters.
//
// Vamos a crear una sola instancia, evitando que fuera de esta clase se puedan crear más instancias.
// Para ello, lo más fácil es que la clase UsuarioService sea privada y a la vez exportamos la única instancia de la app.
//
// Para redibujar los widgets usaremos Stream y un StreamController.
// Usando el getter, desde los widgets se podrán suscribir a los cambios de estado del usuario.
//
// Por defecto, cuando se crea un StreamController, este se crea como un Single Subscription Stream,
// lo que significa que solo se puede escuchar una vez, y lo escucha el StreamBuilder de `pagina1_page.dart`.
// Y dará error si se intenta crear un segundo StreamBuilder. Se tiene que cancelar el primero antes de crear un segundo.
// Para que un StreamController pueda ser escuchado por todo el mundo, se debe crear como un Broadcast Stream, de ahí
// el uso de `StreamController<Usuario>.broadcast()`.
class _UsuarioService {
  Usuario? _usuario;

  final StreamController<Usuario> _usuarioStreamController = StreamController<Usuario>.broadcast();

  Usuario? get usuario => _usuario;
  bool get existeUsuario => _usuario != null ? true : false;

  Stream<Usuario> get usuarioStream => _usuarioStreamController.stream;

  void cargarUsuario(Usuario user) {
    _usuario = user;
    // Añadimos la información del usuario al stream.
    _usuarioStreamController.add(user);
  }

  void cambiarEdad(int edad) {
    if (_usuario != null) {
      _usuario!.edad = edad;
      // Añadimos la información del usuario al stream.
      _usuarioStreamController.add(_usuario!);
    }
  }

  // Para prevenir fugas de memoria, es importante cerrar el StreamController cuando ya no se necesite.
  void dispose() {
    _usuarioStreamController.close();
  }
}

final usuarioService = _UsuarioService();