class Band {
  final String id;
  final String name;
  final int votes;

  Band({
    required this.id,
    required this.name,
    this.votes = 0,
  });

  // Cuando estemos conectando nuestra parte de la app de Flutter con el backend, este va a responder con un mapa.
  // La comunicación va a ser mediante sockets y quiero que estos responden con un mapa, cosa que me viene bien
  // porque en el futuro se puede expandir.

  // Creamos un factory constructor.
  // Esto es un constructor que recibe cierto tipo de argumentos y regresa una nueva instancia de la clase.
  factory Band.fromMap(Map<String, dynamic> obj) 
    => Band(
      id: obj['id'],
      name: obj['name'],
      votes: obj['votes'],
    );
}