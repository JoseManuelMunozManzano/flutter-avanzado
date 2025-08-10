// Como se encuetra el estado de la aplicación (si el usuario esta logeado, cuánto vale el contador, cuántos productos tengo...)

// Indicamos que este archivo user_state.dart es parte de user_bloc.dart
// Las importaciones las vemos en user_bloc.dart
part of 'user_bloc.dart';

// Clase abstracta que no puede cambiar.
// Crearemos clases que extiendan de esta y que tendrán el estado que queramos.
// Se hace así porque nos ayuda a cambiar el estado más fácilmente.
@immutable
abstract class UserState {
  final bool existUser;
  final Usuario? user;

  const UserState({
    this.existUser = false,
    this.user}
  );
}

// Estado inicial.
// Cuando creemos una instancia de UserInitalState, regresaremos este estado.
class UserInitialState extends UserState {
  const UserInitialState(): super(existUser: false, user: null);
}

// Estado cuando tenemos un usuario.
class UserSetState extends UserState {
  final Usuario newUser;

  const UserSetState(this.newUser)
    : super(existUser: true, user: newUser);
}