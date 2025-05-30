class Sugerencia {
  final int? id; // ID auto-incremental
  final int rating; // Calificación (1-5 estrellas)
  final String texto; // Texto de la sugerencia

  Sugerencia({this.id, required this.rating, required this.texto});

  // Convertir a mapa para insertar en SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'texto': texto,
    };
  }

  // Crear desde un mapa (para obtener datos de SQLite)
  factory Sugerencia.fromMap(Map<String, dynamic> map) {
    return Sugerencia(
      id: map['id'],
      rating: map['rating'],
      texto: map['texto'],
    );
  }
}
