import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/models/usuario.dart';

// Importación especial. Indicamos que usuario_state.dart va a ser PARTE de este archivo.
// usuario_cubit.dart sería el archivo padre.
// Con esto, las importaciones son más pequeñas.
part 'usuario_state.dart';

// Necesitamos indicar el tipo de información que va a fluir dentro de el.
// En este caso, vamos a aceptar clases que extiendan de UsuarioState.
class UsuarioCubit extends Cubit<UsuarioState> {
  // En el constructor indicamos el valor inicial.
  UsuarioCubit() : super(UsuarioInitial());

  // Cuando llamen a este método, emitiremos un nuevo estado.
  // Vale cualquier estado que extienda de UsuarioState.
  void seleccionarUsuario(Usuario user) {
    emit(UsuarioActivo(user));
  }

  void cambiarEdad(int edad) {
    // currentState es más flexible que state, por eso lo creamos.
    final currentState = state;

    // Vemos como cambiar el estado.
    // Tener en cuenta que si nuestro estado es UsuarioInitial, entonces, como no hay usuario,
    // no vamos a poder cambiar la edad.
    if (currentState is UsuarioActivo) {
      // Recordar que esto no vale porque siempre debemos emitir un nuevo estado, no mutarlo
      // como en este caso!!!
      //
      // currentState.usuario.edad = 30;
      // emit(UsuarioActivo(currentState.usuario));

      // Regresaremos una nueva instancia de nuestro usuario.
      final newUser = currentState.usuario.copyWith(edad: 30);
      emit(UsuarioActivo(newUser));
    }
  }

  void agregarProfesion() {
    final currentState = state;

    if (currentState is UsuarioActivo) {
      final newProfesiones = [
        ...currentState.usuario.profesiones,
        'Profesión ${currentState.usuario.profesiones.length + 1}',
      ];
      final newUser = currentState.usuario.copyWith(
        profesiones: newProfesiones,
      );
      emit(UsuarioActivo(newUser));
    }
  }

  void borrarUsuario() {
    emit(UsuarioInitial());
  }
}
