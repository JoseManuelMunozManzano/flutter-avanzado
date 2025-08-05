// Aquí indicamos que este fichero va a ser PARTE DE usuario_cubit.dart.
// usuario_state.dart sería un archivo hijo.
part of 'usuario_cubit.dart';

// Los estados son inmutables y los tipados son importantes.
// Por eso creamos la clase abstracta.
@immutable
abstract class UsuarioState {}

// Estado inicial de mi app.
class UsuarioInitial extends UsuarioState {
  final existeUsuario = false;

  @override
  String toString() {
      return 'UsuarioInicial: existeUsuario: false';
  }
}

// Estado al pulsar Establecer Usuario.
// Notar que extiende de UsuarioState.
class UsuarioActivo extends UsuarioState {
  final existeUsuario = true;
  final Usuario usuario;  // La importación de Usuario se hace en usuario_cubit.dart

  UsuarioActivo(this.usuario);
}