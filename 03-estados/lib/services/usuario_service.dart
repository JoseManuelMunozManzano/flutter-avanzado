import 'package:flutter/widgets.dart';

import 'package:estados/models/usuario.dart';

// Para que funcione con el provider, tenemos que pasarlo por el mixin ChangeNotifier
class UsuarioService with ChangeNotifier {
  
  Usuario? _usuario;

  Usuario? get usuario => _usuario;
  bool get existeUsuario => _usuario != null ? true : false;

  // Cargo el usuario y notifico a los listeners que utilizan mi instancia de Provider para que actulicen la UI.
  set usuario(Usuario? user) {
    _usuario = user;
    notifyListeners();
  }

  void cambiarEdad(int edad) {
    if (existeUsuario) {
      _usuario!.edad = edad;
      notifyListeners();
    }
  }

  void removerUsuario() {
    _usuario = null;
    notifyListeners();
  }

  void agregarProfesion() {
    if (existeUsuario) {
      _usuario!.profesiones.add('Profesion ${_usuario!.profesiones.length + 1}');
      notifyListeners();
    }
  }
}