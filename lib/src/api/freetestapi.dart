import 'dart:convert';
import 'package:app_zoologico/src/model/animal.dart';
import 'package:http/http.dart' as http;

Future<List<Animal>> fetchAnimals(String animalName) async {
  final response = await http.get(Uri.parse('https://freetestapi.com/api/v1/animals?search=$animalName'));
  if (response.statusCode == 200) {
    final List<dynamic> animalJson = jsonDecode(response.body);
    return animalJson.map((json) => Animal.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar los datos de la API');
  }
}
