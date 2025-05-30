import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalInfo {
  final String id;
  String name;
  final String imageUrl;
  final String description;
  final List<dynamic> taxonomy;
  final List<dynamic> locations;
  final List<dynamic> characteristics;

  AnimalInfo({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description = '',
    required this.taxonomy,
    required this.locations,
    required this.characteristics,
  });

  factory AnimalInfo.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return AnimalInfo(
      id: doc.id,
      name: data['name'],
      imageUrl: data['image_url'],
      description: data['description'],
      taxonomy: data['taxonomy'],
      locations: data['locations'],
      characteristics: data['characteristics'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image_url': imageUrl,
      'description': description,
      'taxonomy': taxonomy,
      'locations': locations,
      'characteristics': characteristics,
    };
  }

  factory AnimalInfo.fromJson(Map<String, dynamic> json) {
    return AnimalInfo(
      // json['name'],
      // json['description'],
      // json['image'],
      name: json['name'] ?? '',
      taxonomy: json['taxonomy'] ?? [],
      locations: json['locations'] ?? [],
      characteristics: json['characteristics'] ?? [], id: '', imageUrl: '',
    );
  }
}
