import 'package:app_zoologico/src/pages/home.dart';
import 'package:app_zoologico/src/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:app_zoologico/src/model/animal_model.dart';
import 'package:app_zoologico/src/repositories/animal_repository.dart';

class AnimalInfoPage extends StatelessWidget {
  final String animalId;
  final AnimalRepository _animalRepository = AnimalRepository();

  AnimalInfoPage({super.key, required this.animalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<AnimalInfo>(
          future: _animalRepository.getAnimalById(animalId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Cargando...'); // Título mientras carga
            } else if (snapshot.hasData) {
              return Text(
                  snapshot.data!.name); // Título con el nombre del animal
            } else {
              // Si hay error o no hay datos, muestra un título genérico o el ID
              return Text('Animal: $animalId');
            }
          },
        ),
        // === FIN DE MODIFICACIÓN CLAVE ===
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<AnimalInfo>(
        future: _animalRepository.getAnimalById(
            animalId), // Este FutureBuilder es para el cuerpo de la página
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final animalInfo = snapshot.data!;

            return Card(
              margin: const EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                      children: [
                        animalInfo.imageUrl.isNotEmpty
                            ? Image.network(
                                animalInfo.imageUrl,
                                height: 300,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 100),
                              )
                            : Container(
                                height: 300,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Text('No hay imagen disponible')),
                              ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            animalInfo.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        if (animalInfo.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                            animalInfo.description,
                            style: const TextStyle(fontSize: 16),
                          ),),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                          'Taxonomía: ${animalInfo.taxonomy.join(', ')}',
                          style: const TextStyle(fontSize: 16),
                        ),),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                          'Ubicaciones: ${animalInfo.locations.join(', ')}',
                          style: const TextStyle(fontSize: 16),
                        ),),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Text('Características',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                        Column(children: [
                          ...animalInfo.characteristics.map((char) => Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('• $char',
                                    style: TextStyle(fontSize: 16)),
                              )),
                        ]),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu())),
                           child: const Text('Volver al Inicio'),
                          )
                      ],
                    ),
            );
          } else {
            return const Center(
                child: Text('No se encontraron datos del animal.'));
          }
        },
      ),
    );
  }
}
