import 'dart:convert';
import 'package:app_zoologico/src/model/animal_model.dart';
import 'package:http/http.dart' as http;

Future<AnimalInfo> fetchAnimals(String animal) async {
  String url = 'https://api.jsongpt.com/json?prompt=Dame informacion acerca de $animal&taxonomy=array&locations=array&characteristics=array';
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final Map<String, List<String>> formattedData = {
      'taxonomy': (data['taxonomy'] as List<dynamic>).cast<String>().toList(),
      'locations': (data['locations'] as List<dynamic>).cast<String>().toList(),
      'characteristics': (data['characteristics'] as List<dynamic>).cast<String>().toList(),
    };
    AnimalInfo animalInfo = AnimalInfo.fromJson(formattedData);
    animalInfo.name = animal;
    return animalInfo;
  } else {
    throw Exception('Failed to load animals');
  }
}