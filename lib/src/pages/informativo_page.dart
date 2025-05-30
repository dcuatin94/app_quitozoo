import 'package:flutter/material.dart';

class InformativoPage extends StatelessWidget {
  InformativoPage({super.key});

  final List<Map<String, String>> data = [
    {
      'image': 'assets/images/educacion.jpg',
      'title': 'Educación',
      'description':
          'Hemos creado una sección de educación donde podrás encontrar información sobre diferentes temas relacionados con la educación.',
    },
    {
      'image': 'assets/images/bienestar.jpg',
      'title': 'Bienestar Animal',
      'description':
          'El zoológico de Quito se compromete con el bienestar animal. En esta sección, encontrarás información sobre el cuidado y el bienestar de los animales en nuestro zoo.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: data.map((item) {
              return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        child: Image.asset(
                          item['image'] ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        title: Text(item['title'] ?? ''),
                        subtitle: Text(item['description'] ?? ''),
                      ),
                    ],
                  ));
            }).toList(),
          ),
        ));
  }
}
