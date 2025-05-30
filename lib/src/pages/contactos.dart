import 'package:flutter/material.dart';

class ContactosScreen extends StatelessWidget {
  const ContactosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contáctanos!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          // Ubicación
          const ListTile(
            leading: Icon(Icons.location_on, color: Colors.blue),
            title: Text('Nuestra Ubicación'),
            subtitle: Text('Guayllabamba / Quito-Ecuador'),
          ),
          const Divider(),
          // Correo Electrónico
          const ListTile(
            leading: Icon(Icons.email, color: Colors.blue),
            title: Text('Email'),
            subtitle: Text('reservaciones@quitozoo.org'),
          ),
          const Divider(),
          // Teléfono
          const ListTile(
            leading: Icon(Icons.phone, color: Colors.blue),
            title: Text('Llamanos'),
            subtitle: Text('+593 (02) 359-1142 '),
          ),
          const Divider(),
          // Redes Sociales
          const Text(
            'Siguenos en nuestras redes sociales:',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.blue),
                onPressed: () {
                  // Acción para abrir Facebook
                },
              ),
              IconButton(
                icon: const Icon(Icons.linked_camera, color: Colors.blue),
                onPressed: () {
                  // Acción para abrir LinkedIn
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
