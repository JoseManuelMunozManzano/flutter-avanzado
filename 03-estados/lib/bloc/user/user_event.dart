// Son acciones que podemos disparar, que va a recibir el bloc y cambiar el state.

// Indicamos que este archivo user_event.dart es parte de user_bloc.dart
// Las importaciones las vemos en user_bloc.dart
part of 'user_bloc.dart';

// Los eventos se trabajan con clases abstractas inmutables.
// Crearemos eventos que extiendan de UserEvent.
// El objetivo real de este UserEvent es que nuestro bloc sepa que eventos va a poder esperar, lo de tipo UserEvent.
@immutable
abstract class UserEvent {}

// Cuando hagamos click en el botón Establece Usuario, vamos a disparar este evento.
class ActivateUser extends UserEvent {
  final Usuario user;
  ActivateUser(this.user);
}

class ChangeUserAge extends UserEvent {
  final int age;
  ChangeUserAge(this.age);
}

class AddUserProfession extends UserEvent {
  final String profession;
  AddUserProfession(this.profession);
}

class DeleteUser extends UserEvent {}
