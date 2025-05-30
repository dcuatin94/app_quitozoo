import 'package:app_zoologico/src/model/animal.dart';
import 'package:app_zoologico/src/api/freetestapi.dart';
import 'package:flutter/material.dart';

class AnimalListPage extends StatelessWidget {
  final String name;
  final String image;
  const AnimalListPage({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animales del Zoológico')),
      body: FutureBuilder<List<Animal>>(
        future: fetchAnimals( name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron animales'));
          } else {
            final animals = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                return Container(
                  color: Colors.green.shade100,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          image,
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Text("Imagen no disponible"),
                          ),
                        ),
                        Container(
                          color: Colors.green.shade300,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ]),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ListTile(
                                  subtitle: Text(
                                    'Especie: ${animal.species}\nFamilia: ${animal.family} \nHábitat: ${animal.habitat}\nLocalización: ${animal.placeOfFound}\nDieta: ${animal.diet}\nDescripcion: ${animal.description}'
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
