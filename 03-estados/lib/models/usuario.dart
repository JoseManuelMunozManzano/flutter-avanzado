// Es muy común indicar las propiedades como final, para evitar que se puedan mutar.
class Usuario {
  final String nombre;
  final int edad;
  final List<String> profesiones;

  Usuario({
    required this.nombre,
    required this.edad,
    required this.profesiones,
  });

  // Este método es muy común en Cubit y BLoC. Devuelve una nueva instancia de usuario.
  // Cada uno de los parámetros es opcional.
  Usuario copyWith({String? nombre, int? edad, List<String>? profesiones}) => Usuario(
    // Si no recibo el nombre que viene como argumento, usaré el valor original de la instancia.
    nombre: nombre ?? this.nombre,
    edad: edad ?? this.edad,
    profesiones: profesiones ?? this.profesiones,
  );
}
