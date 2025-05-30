class Animal {
  final String name;
  final String species;
  final String family;
  final String habitat;
  final String placeOfFound;
  final String diet;
  final String description;

  Animal({
    required this.name, 
    required this.species,
    required this.family,
    required this.habitat,
    required this.placeOfFound,
    required this.diet,
    required this.description
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      species: json['species'],
      family: json['family'],
      habitat: json['habitat'],
      placeOfFound:json['place_of_found'],
      diet: json['diet'],
      description: json['description'],
    );
  }
}