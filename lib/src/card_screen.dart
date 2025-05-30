import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card con Estilos'),
        backgroundColor: Colors.green, // Estilo personalizado para AppBar
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Añadir un margen alrededor de la Card
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
          ),
          elevation: 5, // Sombra debajo de la Card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen en la parte superior de la Card
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.asset(
                  'assets/galeria/leon.jpg', // Ruta de la imagen
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título del animal
                    Text(
                      'El León - El Rey de la Selva',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.green[700], // Cambia el color del texto
                          ),
                    ),
                    const SizedBox(
                        height: 10), // Espacio entre título y descripción
                    // Descripción del animal
                    Text(
                      'El león es una de las especies más emblemáticas del mundo animal. '
                      'Es conocido por su fuerza, valentía y liderazgo en la manada. '
                      'Habita principalmente en las sabanas africanas.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
