import 'package:get/get.dart';

import 'package:estados/models/usuario.dart';

// Para que esta clase sea un controlador de GetX, lo extendemos de GetxController.
// Con esto tenemos ciclos de vida, etc., pero lo principal es que podemos transformar
// el valor de la variable booleana existeUsuario en un Observable o un Stream que emita valores booleanos.
// Para eso usamos .obs, cuando el tipo es RxBool (programación reactiva).
// La variable Usuario también necesitamos que sea un Observable, para redibujar si su valor cambia.
class UsuarioController extends GetxController {
  var existeUsuario = false.obs;
  var usuario = Usuario().obs;

  int get profesionesCount {
    return usuario.value.profesiones.length;
  }

  // Para cambiar el usuario cuando tengamos uno.
  // Lo que hacemos es añadir al stream existeUsuario el valor true, y al stream usuario el valor pUsuario.
  // Esta es una manera de trabajar, pero hay más y veremos alguna más.
  void cargarUsuario(Usuario pUsuario) {
    existeUsuario.value = true;
    usuario.value = pUsuario;
  }

  // Para cambiar la edad.
  // Vemos como cambiar solo una propiedad de un observable.
  void cambiarEdad(int pEdad) {
    usuario.update((val) => val!.edad = pEdad);
  }

  void agregarProfesion(String profesion) {
    usuario.update((val) => val!.profesiones = [...val.profesiones, profesion]);
  }
}