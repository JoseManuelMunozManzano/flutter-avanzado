// Es quien tiene la información de cual es el estado actual y procesa los eventos.
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:estados/models/usuario.dart';

// Con esto, ahorramos varias importaciones y nos permite trabajar estos 3 archivos como si fuera uno solo.
part 'user_event.dart';
part 'user_state.dart';

// A Bloc tenemos que pasarle los tipos de evento y los tipos de estado que puede manejar.
// Indicamos las clases abstractas que creamos en sus respectivos archivos.
// Y solo vamos a poder trabajar con clases que sean extendidas de estas dos clases abstractas.
class UserBloc extends Bloc<UserEvent, UserState> {

  // En el constructor tenemos que indicar el estado inicial y el manejo de los eventos.
  UserBloc(): super(const UserInitialState()) {

    // Aquí indicamos la función que se va a ejecutar si se recibe un evento de tipo ActivateUser.
    // El parámetro emit nos sirve para emitir un nuevo estado de manera condicional.
    on<ActivateUser>((event, emit) => emit(UserSetState(event.user)));

    on<DeleteUser>((event, emit) => emit(UserInitialState()));

    on<ChangeUserAge>((event, emit) {
      // Aunque state no está en ningún lugar, tengo acceso a el porque UserBloc entiende de Bloc, y ahí es donde está el state.
      if (!state.existUser) return;

      // No es buena práctica mutar el estado. Esto funcionaría, pero no hacerlo.
      // Siempre hay que generar un nuevo estado y, para evitar mutarlo, modificamos
      // el modelo usuario.dart para añadir el método copyWith().
      //
      // state.user!.edad = event.age;

      emit(UserSetState(state.user!.copyWith(edad: event.age)));
    });

    on<AddUserProfession>((event, emit) {
      if (!state.existUser) return;
      final professions = [...state.user!.profesiones, event.profession];

      emit(UserSetState(state.user!.copyWith(profesiones: professions)));
    });

  }
}